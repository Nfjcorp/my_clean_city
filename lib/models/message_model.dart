class MessageModel {
  final String message;
  final bool isUser;
  final DateTime timeSpam;

  MessageModel({
    required this.message,
    required this.isUser,
    required this.timeSpam,
  });
}
