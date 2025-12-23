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
  MedicalHistory: 16,
  OtherPersonalInfo: 16,
  JobPreferences: 16,
  UploadedDocuments: 20,
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
    const triggerTableName = fullTableName.split("-")[0];

    console.log(`Processing update for simple table name: ${triggerTableName}`);

    if (!SECTION_WEIGHTS[triggerTableName]) {
      console.log(
        `Skipping record because ${triggerTableName} is not a tracked section.`
      );
      continue;
    }

    const userId = record.dynamodb.NewImage.userID.S;

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

      const getResponse = await client.send(
        new QueryCommand({
          TableName: deployedTableName,
          IndexName: "byUser", 
          KeyConditionExpression: "userID = :u",
          ExpressionAttributeValues: {
            ":u": { S: userId },
          },
          Limit: 1,
        })
      );

      if (!getResponse.Items || getResponse.Items.length === 0) {
        console.log(
          `Skipping scoring for ${section}: No item found for user ${userId}.`
        );
        continue;
      }

      // Query returns an array of items (Items), get the first one
      const item = unmarshall(getResponse.Items[0]);

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
