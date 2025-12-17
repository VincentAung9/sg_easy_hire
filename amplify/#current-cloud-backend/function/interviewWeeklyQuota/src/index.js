/* Amplify Params - DO NOT EDIT
	API_EASYHIRE_GRAPHQLAPIENDPOINTOUTPUT
	API_EASYHIRE_GRAPHQLAPIIDOUTPUT
	API_EASYHIRE_GRAPHQLAPIKEYOUTPUT
	API_EASYHIRE_INTERVIEWTABLE_ARN
	API_EASYHIRE_INTERVIEWTABLE_NAME
	ENV
	REGION
Amplify Params - DO NOT EDIT */
// Example Lambda Handler (using AWS SDK v3)
const { DynamoDBClient } = require("@aws-sdk/client-dynamodb");
const { DynamoDBDocumentClient, QueryCommand } = require("@aws-sdk/lib-dynamodb");

const client = new DynamoDBClient({});
const docClient = DynamoDBDocumentClient.from(client);

// Helper function to get the start of the rolling week (7 days ago)
function getStartOfWeekDate() {
    const d = new Date();
    // Go back 7 days and set to midnight UTC for the start of the counting window
    d.setUTCDate(d.getUTCDate() - 7); 
    d.setUTCHours(0, 0, 0, 0); 
    return d.toISOString();
}

exports.handler = async (event) => {
    // 1. INPUTS & CONSTANTS
    const employerID = event.arguments.employerID;
    const startDate = getStartOfWeekDate();
    const InterviewTableName = process.env.API_EASYHIRE_INTERVIEWTABLE_NAME; 
    const MAX_QUOTA = 10; 

    // 2. DYNAMODB QUERY SETUP
    const params = {
        TableName: InterviewTableName,
        IndexName: 'byEmployerInterview', 
        KeyConditionExpression: 'employerID = :id',
        // Filter by confirmed date (>= 7 days ago) AND status ('CONFIRMED' or 'COMPLETED')
        FilterExpression: 'confirmedDateTime >= :date AND (#s = :acce OR #s = :comp)',
        ExpressionAttributeNames: {
            '#s': 'status' 
        },
        ExpressionAttributeValues: {
            ':id': employerID,
            ':date': startDate,
            ':acce': 'ACCEPTED',
            ':comp': 'COMPLETED'
        },
        Select: 'COUNT' // Only return the item count
    };

    // 3. EXECUTION AND RETURN
    try {
        const queryResult = await docClient.send(new QueryCommand(params));

        return {
            employerID: employerID,
            currentUsage: queryResult.Count, // The calculated count
            maxQuota: MAX_QUOTA             // The hardcoded value
        };
    } catch (error) {
        console.error("DynamoDB Query Error:", error);
        throw new Error("Failed to calculate weekly quota.");
    }
};