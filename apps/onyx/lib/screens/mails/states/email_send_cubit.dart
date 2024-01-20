import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

part 'email_send_state.dart';
part 'generated/email_send_cubit.g.dart';

class EmailSendCubit extends Cubit<EmailSendState> {
  EmailSendCubit(int? originalMessage, bool? replyAll, bool reply, bool forward)
      : super(EmailSendState(status: EmailSendStatus.initial)) {
    emit(state.copyWith(
      status: EmailSendStatus.updated,
      originalMessage: originalMessage,
      replyAll: replyAll,
      reply: reply,
      forward: forward,
      controller: QuillController.basic(),
      subjectEditor: TextEditingController(),
      destinationEditor: TextEditingController(),
      attachments: [],
    ));
  }

  void addAttachment(File file) {
    List<File> attachments = List.from(state.attachments);
    attachments.add(file);
    emit(state.copyWith(attachments: attachments));
  }

  void addAttachments(List<File> files) {
    List<File> attachments = List.from(state.attachments);
    attachments.addAll(files);
    emit(state.copyWith(attachments: attachments));
  }

  void removeAttachment(File file) {
    List<File> attachments = List.from(state.attachments);
    attachments.remove(file);
    emit(state.copyWith(attachments: attachments));
  }
}
