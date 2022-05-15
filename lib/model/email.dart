class EmailModel {
  final String subject;
  final String sender;
  final String excerpt;
  final bool isRead;
  final DateTime date;

  EmailModel({
    required this.subject,
    required this.sender,
    required this.excerpt,
    required this.isRead,
    required this.date,
  });
}
