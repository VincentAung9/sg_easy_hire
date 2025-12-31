import 'package:sg_easy_hire/models/ModelProvider.dart';

class ChatScreenParam {
  final UserRole userRole;
  final ChatRoom chatRoom;
  final User finalReceiverUser;
  final User sender;
  ChatScreenParam({
    required this.userRole,
    required this.chatRoom,
    required this.finalReceiverUser,
    required this.sender,
  });
}
