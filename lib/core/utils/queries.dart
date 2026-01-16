const chatRoomsQuery = r'''
query ListChatRoomsWithMessages($userID: ID!) {
  listChatRooms(
    filter: {
      or: [
        { userAID: { eq: $userID } }
        { userBID: { eq: $userID } }
      ]
    }
    limit: 1000
  ) {
    items {
      id
      name
      userAID
      userBID
      createdAt
      
      supportTicket{
        id
        subject
        description
        status
        relatedModelID  
        relatedModelType
        createdAt
        updatedAt
      }

      userA {
        id
        fullName
        avatarURL
        phone
      }

      userB {
        id
        fullName
        avatarURL
        phone
      }

      chatMessages {
        items {
          id
          content
          senderID
          receiverID
          status
          createdAt

          sender {
            id
            fullName
            avatarURL
            phone
          }

          receiver {
            id
            fullName
            avatarURL
            phone
          }
        }
      }
    }
  }
}
''';

const hiredJobQuery = r'''
query ListHiredJobs($userID: ID!) {
  listHiredJobs(
    filter: {
      or: [
        { userAID: { eq: $userID } }
        { userBID: { eq: $userID } }
      ]
    }
    limit: 1000
  ) {
    items {
      id
      name
      userAID
      userBID
      createdAt

      userA {
        id
        fullName
        avatarURL
        phone
      }

      userB {
        id
        fullName
        avatarURL
        phone
      }

      chatMessages {
        items {
          id
          content
          senderID
          receiverID
          status
          createdAt

          sender {
            id
            fullName
            avatarURL
            phone
          }

          receiver {
            id
            fullName
            avatarURL
            phone
          }
        }
      }
    }
  }
}
''';

const String hiredJobsQuery = '''
  query GetHiredJobs(\$filter: ModelHiredJobFilterInput) {
    listHiredJobs(filter: \$filter) {
        items {
         createdAt
         updatedAt
         id
        code
        status
        adminActionStatus
        updatedBy
        startDate
        endDate
        completedProcesses
        job {
            id
            code
            title
            location
            salary
            currency
        }
        helper {
            id
            code
            cognitoId
            fullName
            email
            phone
            avatarURL
        }
        employer {
            id
            code
            cognitoId
            fullName
            email
            phone
            avatarURL
         }
        }
      }
    }
  ''';

const String jobOffersQuery = '''
query GetJobOffers(\$filter: ModelJobOfferFilterInput) {
  listJobOffers(filter: \$filter) {
    items {
      createdAt
      updatedAt
      id
      code
      status
      adminActionStatus
      updatedBy
      customFields
      completedProcesses
      job {
        createdAt
        updatedAt
        id
        code
        title
        location
        salary
        currency
        payPeriod
        familyMembers
        childCount
        adultCount
        childAges
        elderlyCount
        homeType
        roomType
        requiredSkills
        note
        accommodation
        offdays
        tags
        requiredPersonalityType
        status
        jobType
        startDate
        contract
        responsibilities
        isActive
        creator {
          id
          code
          cognitoId
          fullName
          email
          phone
          avatarURL
        }
      }
      helper {
        id
        code
        cognitoId
        fullName
        email
        phone
        avatarURL
      }
      employer {
        id
        code
        cognitoId
        fullName
        email
        phone
        avatarURL
      }
    }
  }
}
''';
