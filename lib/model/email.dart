class EmailModel {
  final String subject;
  final String sender;
  final String receiver;
  final String excerpt;
  final String body;
  final int? sequenceId;
  final bool isRead;
  final DateTime date;

  EmailModel({
    required this.subject,
    required this.sender,
    required this.receiver,
    required this.excerpt,
    required this.body,
    required this.sequenceId,
    required this.isRead,
    required this.date,
  });
}
