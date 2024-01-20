part of 'email_send_cubit.dart';

enum EmailSendStatus { initial, sending, sent, updated, error }

@CopyWith()
class EmailSendState {
  EmailSendStatus status;
  final QuillController? controller;
  final TextEditingController? subjectEditor;
  final TextEditingController? destinationEditor;
  final int? originalMessage;
  final List<File> attachments;
  final bool? replyAll;
  final bool? reply;
  final bool? forward;

  EmailSendState({
    required this.status,
    this.controller,
    this.subjectEditor,
    this.destinationEditor,
    this.originalMessage,
    this.replyAll,
    this.reply,
    this.forward,
    this.attachments = const [],
  });
}
