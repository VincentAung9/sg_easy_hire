/* Amplify Params - DO NOT EDIT
	API_EASYHIRE_GRAPHQLAPIENDPOINTOUTPUT
	API_EASYHIRE_GRAPHQLAPIIDOUTPUT
	API_EASYHIRE_GRAPHQLAPIKEYOUTPUT
	ENV
	REGION
Amplify Params - DO NOT EDIT */ /* Amplify Params - DO NOT EDIT
  API_EASYHIRE_APPLIEDJOBTABLE_ARN
  API_EASYHIRE_APPLIEDJOBTABLE_NAME
  API_EASYHIRE_CONTACTFAMILYDETAILSTABLE_ARN
  API_EASYHIRE_CONTACTFAMILYDETAILSTABLE_NAME
  API_EASYHIRE_GRAPHQLAPIENDPOINTOUTPUT
  API_EASYHIRE_GRAPHQLAPIIDOUTPUT
  API_EASYHIRE_GRAPHQLAPIKEYOUTPUT
  API_EASYHIRE_INTERVIEWTABLE_ARN
  API_EASYHIRE_INTERVIEWTABLE_NAME
  API_EASYHIRE_JOBPREFERENCESTABLE_ARN
  API_EASYHIRE_JOBPREFERENCESTABLE_NAME
  API_EASYHIRE_JOBTABLE_ARN
  API_EASYHIRE_JOBTABLE_NAME
  API_EASYHIRE_MEDICALHISTORYTABLE_ARN
  API_EASYHIRE_MEDICALHISTORYTABLE_NAME
  API_EASYHIRE_OTHERPERSONALINFORMATIONSTABLE_ARN
  API_EASYHIRE_OTHERPERSONALINFORMATIONSTABLE_NAME
  API_EASYHIRE_PERSONALINFORMATIONTABLE_ARN
  API_EASYHIRE_PERSONALINFORMATIONTABLE_NAME
  API_EASYHIRE_SAVEDHELPERTABLE_ARN
  API_EASYHIRE_SAVEDHELPERTABLE_NAME
  API_EASYHIRE_SAVEDJOBTABLE_ARN
  API_EASYHIRE_SAVEDJOBTABLE_NAME
  API_EASYHIRE_UPLOADEDDOCUMENTSTABLE_ARN
  API_EASYHIRE_UPLOADEDDOCUMENTSTABLE_NAME
  API_EASYHIRE_USERANSWERTABLE_ARN
  API_EASYHIRE_USERANSWERTABLE_NAME
  API_EASYHIRE_USERTABLE_ARN
  API_EASYHIRE_USERTABLE_NAME
  ENV
  REGION
Amplify Params - DO NOT EDIT */ const {
  DynamoDBClient,
  // GetItemCommand,
  QueryCommand,
  UpdateItemCommand,
} = require("@aws-sdk/client-dynamodb");
const { unmarshall } = require("@aws-sdk/util-dynamodb");

const client = new DynamoDBClient();

// --- FINAL: Map logical section names to deployed DynamoDB table names ---
const TABLE_MAP = {
  PersonalInformation: process.env.API_EASYHIRE_PERSONALINFORMATIONTABLE_NAME,
  ContactFamilyDetails: process.env.API_EASYHIRE_CONTACTFAMILYDETAILSTABLE_NAME,
  MedicalHistory: process.env.API_EASYHIRE_MEDICALHISTORYTABLE_NAME,
  OtherPersonalInformations:
    process.env.API_EASYHIRE_OTHERPERSONALINFORMATIONSTABLE_NAME,
  JobPreferences: process.env.API_EASYHIRE_JOBPREFERENCESTABLE_NAME,
  UploadedDocuments: process.env.API_EASYHIRE_UPLOADEDDOCUMENTSTABLE_NAME,
  // Target table for the final update
  User: process.env.API_EASYHIRE_USERTABLE_NAME,
};
// ----------------------------------------------------------------------

// Section weights (remains the same)
const SECTION_WEIGHTS = {
  PersonalInformation: 16,
  ContactFamilyDetails: 16,
  MedicalHistory: 16,
  OtherPersonalInformations: 16,
  JobPreferences: 16,
  UploadedDocuments: 20,
};

// Required fields (remains the same)
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
  OtherPersonalInformations: [
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

  // --- INITIAL CHECK: Ensure the User table name is defined before proceeding ---
  if (!TABLE_MAP.User) {
    console.error(
      "FATAL ERROR: User table name environment variable is missing!"
    );
    return; // Stop execution immediately
  }
  // -----------------------------------------------------------------------------

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

    // Loop through all sections and calculate score
    for (const section of Object.keys(SECTION_WEIGHTS)) {
      const deployedTableName = TABLE_MAP[section];

      // --- CRITICAL SAFETY CHECK ---
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
          // <-- CHANGE FROM GetItemCommand to QueryCommand
          TableName: deployedTableName,
          IndexName: "byUser", // <-- Use the GSI name defined in your schema
          KeyConditionExpression: "userID = :u", // <-- Query based on userID field
          ExpressionAttributeValues: {
            ":u": { S: userId },
          },
          Limit: 1, // We only expect one item per user per table
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
