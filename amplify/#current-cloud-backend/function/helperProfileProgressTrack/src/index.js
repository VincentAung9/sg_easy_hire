/* Amplify Params - DO NOT EDIT
	API_EASYHIRE_GRAPHQLAPIENDPOINTOUTPUT
	API_EASYHIRE_GRAPHQLAPIIDOUTPUT
	API_EASYHIRE_GRAPHQLAPIKEYOUTPUT
	ENV
	REGION
Amplify Params - DO NOT EDIT */const {
  DynamoDBClient,
  QueryCommand,
  UpdateItemCommand,
  GetItemCommand
} = require("@aws-sdk/client-dynamodb");
const { unmarshall } = require("@aws-sdk/util-dynamodb");
const client = new DynamoDBClient();

const apiId = process.env.API_EASYHIRE_GRAPHQLAPIIDOUTPUT;
const env = process.env.ENV;

const TABLE_MAP = {
  PersonalInformation: `PersonalInformation-${apiId}-${env}`,
  ContactFamilyDetails: `ContactFamilyDetails-${apiId}-${env}`,
  MedicalHistory: `MedicalHistory-${apiId}-${env}`,
  OtherPersonalInfo: `OtherPersonalInfo-${apiId}-${env}`,
  JobPreferences: `JobPreferences-${apiId}-${env}`,
  UploadedDocuments: `UploadedDocuments-${apiId}-${env}`,
  User: `User-${apiId}-${env}`,
};

const SECTION_WEIGHTS = {
  PersonalInformation: 16,
  ContactFamilyDetails: 16,
  MedicalHistory: 6,
  OtherPersonalInfo: 16,
  JobPreferences: 16,
  UploadedDocuments: 20,
  User:10,
};

const REQUIRED_FIELDS = {
  PersonalInformation: [
    "fullName",
    "dateOfBirth",
    "placeOfBirth",
    "nationality",
    "gender",
    "height",
    "weight",
  ],
  ContactFamilyDetails: [
    "residentialAddress",
    "contactNumber",
    "portAriport",
    "religion",
    "educationLevel",
    "numberOfSiblings",
    "martialStatus",
  ],
  MedicalHistory: ["anyAllergies"],
  OtherPersonalInfo: [
    "foodPreferences",
    "accommodationpreferences",
    "languagesSpoken",
  ],
  JobPreferences: ["expectedMonthlySalary", "preferredOffDaysPerMonth"],
  UploadedDocuments: [
    "profilePhoto",
    "passport",
    "medicalCertificate",
    "policeClearance",
    "educationalCertificates",
  ],
  User: ["skills","nationality","languagesSpoken","age","height","weight","totalExperiences","expectedSalary"],
};


exports.handler = async (event) => {
  console.log("Lambda triggered", JSON.stringify(event, null, 2));

  if (!TABLE_MAP.User) {
    console.error(
      "FATAL ERROR: User table name environment variable is missing!"
    );
    return; 
  }

  for (const record of event.Records) {
    if (record.eventName !== "INSERT" && record.eventName !== "MODIFY") {
      continue;
    }

    const fullTableName = record.eventSourceARN.split("/")[1];
    const triggerTableName = Object.keys(SECTION_WEIGHTS).find(key => 
  fullTableName.startsWith(`${key}-`)
);

if (!triggerTableName) {
   console.log(`Skipping: ${fullTableName} does not match any tracked section.`);
   continue;
}
    let userId;
if (triggerTableName === "User") {
  userId = record.dynamodb.NewImage.id.S;
} else {
  userId = record.dynamodb.NewImage.userID.S;
}

if (!userId) {
  console.log("Could not find a valid User ID in this record. Skipping.");
  continue;
}

    let totalCompletion = 0;

    for (const section of Object.keys(SECTION_WEIGHTS)) {
      const deployedTableName = TABLE_MAP[section];

      if (!deployedTableName) {
        // This should never happen if the environment variables and TABLE_MAP are correct.
        console.error(
          `RUNTIME ERROR: Deployed table name is undefined for section: ${section}. Check TABLE_MAP definition!`
        );
        continue;
      }
      // -----------------------------

      let item;

      // --- SPECIAL HANDLING FOR USER TABLE ---
      if (section === "User") {
        const userResult = await client.send(
          new GetItemCommand({
            TableName: deployedTableName,
            Key: { id: { S: userId } }, // Use 'id' for User table
          })
        );
        if (userResult.Item) item = unmarshall(userResult.Item);
      } 
      // --- STANDARD HANDLING FOR SECTION TABLES ---
      else {
        const getResponse = await client.send(
          new QueryCommand({
            TableName: deployedTableName,
            IndexName: "byUser", // Section tables use the byUser index
            KeyConditionExpression: "userID = :u",
            ExpressionAttributeValues: { ":u": { S: userId } },
            Limit: 1,
          })
        );
        if (getResponse.Items && getResponse.Items.length > 0) {
          item = unmarshall(getResponse.Items[0]);
        }
      }

      if (!item) {
        console.log(`No data found for section ${section} for user ${userId}.`);
        continue;
      }

      const requiredFields = REQUIRED_FIELDS[section] || [];
      // Avoid division by zero
      if (requiredFields.length === 0) continue;

      const filledCount = requiredFields.filter(
        (field) =>
          item[field] !== undefined &&
          item[field] !== null &&
          item[field] !== ""
      ).length;

      const sectionScore =
        (filledCount / requiredFields.length) * SECTION_WEIGHTS[section];

      totalCompletion += sectionScore;
    }

    const userResult = await client.send(
      new GetItemCommand({
        TableName: TABLE_MAP.User,
        Key: { id: { S: userId } },
      })
    );

    if (userResult.Item) {
      const currentUser = unmarshall(userResult.Item);
      const existingProgress = parseFloat(currentUser.completeProgress || 0);

      // Use Math.abs for float comparison (prevents rounding issues)
      if (Math.abs(existingProgress - totalCompletion) < 0.01) {
        console.log(`Skipping update for ${userId}: Progress is already ${existingProgress}%`);
        continue; // STOP HERE, no change detected
      }
    }

    // Update User table with completion %
    await client.send(
      new UpdateItemCommand({
        TableName: TABLE_MAP.User,
        Key: { id: { S: userId } },
        UpdateExpression: "SET completeProgress = :completion",
        ExpressionAttributeValues: {
          ":completion": { N: totalCompletion.toString() },
        },
      })
    );

    console.log(
      `Updated completeProgress for user ${userId} = ${totalCompletion}`
    );
  }
};
