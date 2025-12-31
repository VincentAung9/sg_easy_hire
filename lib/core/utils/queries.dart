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
