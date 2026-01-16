/* Amplify Params - DO NOT EDIT
	API_EASYHIRE_APPLIEDJOBTABLE_ARN
	API_EASYHIRE_APPLIEDJOBTABLE_NAME
	API_EASYHIRE_GRAPHQLAPIENDPOINTOUTPUT
	API_EASYHIRE_GRAPHQLAPIIDOUTPUT
	API_EASYHIRE_GRAPHQLAPIKEYOUTPUT
	API_EASYHIRE_INTERVIEWTABLE_ARN
	API_EASYHIRE_INTERVIEWTABLE_NAME
	API_EASYHIRE_JOBOFFERTABLE_ARN
	API_EASYHIRE_JOBOFFERTABLE_NAME
	API_EASYHIRE_JOBTABLE_ARN
	API_EASYHIRE_JOBTABLE_NAME
	API_EASYHIRE_NOTIFICATIONMODELTABLE_ARN
	API_EASYHIRE_NOTIFICATIONMODELTABLE_NAME
	API_EASYHIRE_SAVEDHELPERTABLE_ARN
	API_EASYHIRE_SAVEDHELPERTABLE_NAME
	API_EASYHIRE_USERTABLE_ARN
	API_EASYHIRE_USERTABLE_NAME
	ENV
	REGION
Amplify Params - DO NOT EDIT */

/**
 * @type {import('@types/aws-lambda').APIGatewayProxyHandler}
 */
const AWS = require('aws-sdk');
// Using the DocumentClient for easier data handling (no S, N, etc.)
const db = new AWS.DynamoDB.DocumentClient(); 
const pinpoint = new AWS.Pinpoint({ region: process.env.REGION }); 
const { unmarshall } = require("@aws-sdk/util-dynamodb"); // To convert DynamoDB Stream format to JSON

// --- Environment Variables and Table Names ---
// These names are constructed by Amplify's environment variables
const API_ID = process.env.API_EASYHIRE_GRAPHQLAPIIDOUTPUT;
const ENV = process.env.ENV;

const USER_TABLE = `User-${API_ID}-${ENV}`;
const JOB_TABLE = `Job-${API_ID}-${ENV}`; // Inferred Job table name
const JOBOFFER_TABLE = `JobOffer-${API_ID}-${ENV}`;
const NOTIFICATION_TABLE = `NotificationModel-${API_ID}-${ENV}`;
const PINPOINT_APP_ID = process.env.PINPOINT_APP_ID;

// --- HELPER FUNCTION: Get User Token ---
/**
 * Retrieves the token and name for a given userId from the User table.
 */
async function getRecipientToken(userId) {
    if (!userId) return null;
    try {
        const params = {
            TableName: USER_TABLE,
            Key: { id: userId },
            ProjectionExpression: '#t, fullName', 
            ExpressionAttributeNames: {
                '#t': 'deviceToken' 
            }
        };
        const result = await db.get(params).promise();
        return result.Item; // Returns { token: '...', fullName: '...' }
    } catch (error) {
        console.error("Error fetching user token:", error);
        return null;
    }
}

// --- HELPER FUNCTION: Send Notification ---
/**
 * Sends a GCM (FCM) push notification using Pinpoint.
 */
async function sendNotification(token, title, body) {
    if (!token || !PINPOINT_APP_ID) return null;
   
    const messageRequest = {
        Addresses: {
            [token]: { ChannelType: 'GCM' }
        },
        MessageConfiguration: {
            GCMMessage: {
                Title: title,
                Body: body,
                Action: 'OPEN_APP', 
                SilentPush: false, 
                Priority: "high",
            }
        }
    };
    
    const params = {
        ApplicationId: PINPOINT_APP_ID,
        MessageRequest: messageRequest
    };

    try {
        const data = await pinpoint.sendMessages(params).promise();
        console.log("🔔 Pinpoint Send Success:", JSON.stringify(data));
        return data;
    } catch (err) {
        console.error("❗️Pinpoint Send Error:", err);
        return null;
    }
}
/**
 * Saves a record of the notification to the NotificationModel table.
 */
async function saveNotification(recipientId, title, body, notificationType, data) {
    // Generate a simple unique ID (for production, consider a UUID library)
    const newId = `notif-${Date.now()}`; 
    
    const params = {
        TableName: NOTIFICATION_TABLE,
        Item: {
            id: newId,
            receiverID: recipientId,
            title: title,
            body: body,
            notificationType: notificationType, // Ensure you map this to the correct Enum value (e.g., 'APPLIEDJOB')
            data: data ? JSON.stringify(data) : null,
            createdAt: new Date().toISOString(),
            updatedAt: new Date().toISOString(),
            // Amplify-related fields are usually added by AppSync resolvers but we add basics for completeness
        }
    };
    
    try {
        await db.put(params).promise();
        console.log("✅ NotificationModel saved successfully:", newId);
    } catch (error) {
        console.error("❗️ Error saving NotificationModel:", error);
    }
}

/**
 * Main Lambda Handler invoked by DynamoDB Streams.
 */
exports.handler = async (event) => {
    console.log("Lambda triggered", JSON.stringify(event, null, 2));
    for (const record of event.Records) {
        // Skip if the record is a removal or if there is no new data
        if (record.eventName === 'REMOVE' || !record.dynamodb.NewImage) {
            continue;
        }

        // Unmarshall the DynamoDB data into a usable JSON object
        // NOTE: The unmarshall utility from '@aws-sdk/util-dynamodb' is used here
        const item = unmarshall(record.dynamodb.NewImage);
        const oldItem = record.dynamodb.OldImage
            ? unmarshall(record.dynamodb.OldImage)
            : null;
        // Extract the base table name from the ARN (e.g., 'SavedHelper')
        const fullTableName = record.eventSourceARN.split('/')[1];
        const tableName = fullTableName.split('-')[0];
        const eventName = record.eventName; 
        
        console.log(`Processing ${eventName} on table ${tableName} with ID: ${item.id}`);

        let recipientId = null;
        let title = '';
        let body = '';
        
        // --- Core Logic: Identify Recipient and Content ---
        switch (tableName) {
            case 'User':
                
                if(eventName === 'MODIFY' && (item.verifyStatus !== oldItem.verifyStatus) && item.updatedBy === 'ADMIN' ){
                    recipientId = item.id; 
                    switch (item.verifyStatus) {
                        case "PENDING":
                            title = "Profile Under Review ⏳";
                            body = "Your profile is being reviewed. We’ll notify you soon.";
                            break;

                        case "VERIFIED":
                            title = "Profile Approved 🎉";
                            body = "Your profile is approved. You can now apply for jobs!";
                            break;

                        case "UNVERIFIED":
                            title = "Verification Needed ⚠️";
                            body = "Your profile couldn’t be verified. Please update and resubmit.";
                            break;

                        default:
                            title = "Profile Updated 🔔";
                            body = "Your profile status has been updated.";
                            break;
                        }
                }
                break;
            case 'SavedHelper':
                if (eventName === 'INSERT') {
                    // Recipient is the Helper
                    recipientId = item.helperID; 
                    title = "Profile Liked!";
                    body = "An employer has liked your profile!";
                }
                break;
                
            case 'AppliedJob':
                if (eventName === 'INSERT') {
                    // Recipient is the Employer, requiring a lookup on the Job table
                    const jobId = item.jobID;
                    
                    try {
                        // 1. Fetch the Job record to get the employerID
                        const jobParams = {
                            TableName: JOB_TABLE,
                            Key: { id: jobId },
                            ProjectionExpression: 'employerID'
                        };
                        const jobResult = await db.get(jobParams).promise();
                        
                        if (jobResult.Item && jobResult.Item.employerID) {
                            recipientId = jobResult.Item.employerID;
                            title = "New Application!";
                            body = "A helper has applied to your job posting.";
                        } else {
                            console.warn(`Job ID ${jobId} not found or missing employerID. Skipping notification.`);
                            continue;
                        }
                    } catch (e) {
                        console.error(`Error fetching Job ID ${jobId}:`, e);
                        continue;
                    }
                }
                break;
                
            case 'Interview':
                if(item.status === 'NO_SHOW'){
                    continue;
                }
                if (eventName === 'INSERT' || eventName === 'MODIFY') {
                    // Recipient is the Helper
                    if(item.updatedBy === 'EMPLOYER'){
                        recipientId = item.helperID;
                    }else{
                        recipientId = item.employerID;
                    }
                    title = (eventName === 'INSERT') ? "New Interview Scheduled!" : "Interview Status Updated!";
                    body = `Your interview status is now: ${item.status}.`;
                    
                    // Optional: You could duplicate the send logic here to also notify the employerID
                }
                break;
            case 'JobOffer':
                if (eventName === 'INSERT' || eventName === 'MODIFY') {
                    // Recipient is the Helper
                    if(item.updatedBy === 'EMPLOYER'){
                        recipientId = item.helperID;
                    }else{
                        recipientId = item.employerID;
                    }
                    title = (eventName === 'INSERT') ? "You’ve Got a Job Offer!" : "Job offer Status Updated!";
                    body =(eventName === 'INSERT') ? `An employer has sent you a job offer. Review the details when you’re ready.`: `Your job offer status is now ${item.status}`;
                    
                    // Optional: You could duplicate the send logic here to also notify the employerID
                }
                break;
                
            default:
                continue; // Skip tables we don't care about
        }
        
        // --- Execution ---
        // --- Execution ---
if (recipientId) {
    console.log(`🌈 Recipient ID: ${recipientId}`);
    const user = await getRecipientToken(recipientId);
    
    // Determine the type string based on the table name
    let notificationType = '';
    switch (tableName) {
        case 'SavedHelper': notificationType = 'LIKEPROFILE'; break;
        case 'AppliedJob': notificationType = 'APPLIEDJOB'; break;
        case 'Interview': notificationType = 'INTERVIEW'; break;
        case 'JobOffer': notificationType = 'JOBOFFER';break;
        default: notificationType = 'OTHER'; break;
    }
    console.log(`🌈 User: ${JSON.stringify(user)}`);
    if (user && user.deviceToken) {
        // 1. Send Pinpoint Notification
        const pinpointResult = await sendNotification(user.deviceToken, title, body);
        
        if (pinpointResult) {
            // 2. ONLY Save to DB if Pinpoint send was attempted/successful
            const notificationData = {
                ...item
            };
            await saveNotification(recipientId, title, body, notificationType, notificationData);
        }
    } else {
        console.log(`❗️Recipient ${recipientId} has no token or user not found. Skipping.`);
    }
}
    }
};