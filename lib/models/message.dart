class Message {
  final String senderId;
  final String senderEmail;
  final String recevireId;
  final String message;
  final String timestamp;

  Message({
    required this.senderId,
    required this.senderEmail,
    required this.recevireId,
    required this.message,
    required this.timestamp,
  });

  //convert to a map
  Map<String, dynamic> toMap() {
    return {
      'senderID': senderId,
      'senderEmail': senderEmail,
      'recevireId': recevireId,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
