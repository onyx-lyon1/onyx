import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:lyon1mailclient/lyon1mailclient.dart';
import 'package:onyx/screens/mails/states/email_cubit.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';

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

  void sendEmail(EmailCubit emailCubit) {
    if ((state.destinationEditor!.value.text.isNotEmpty &&
            state.subjectEditor!.value.text.isNotEmpty &&
            bodyHtml(state.controller!).isNotEmpty &&
            state.destinationEditor!.value.text.contains("@") &&
            state.destinationEditor!.value.text.contains(".")) ||
        (state.originalMessage != null &&
            bodyHtml(state.controller!).isNotEmpty)) {
      Mail email = Mail(
        subject: state.subjectEditor!.text,
        sender: "moi",
        excerpt: "",
        isRead: false,
        date: DateTime.now(),
        body: bodyHtml(state.controller!),
        id: 0,
        receiver: state.destinationEditor!.text,
        isFlagged: false,
        attachments: state.attachments.map((e) => e.path).toList(),
        attachmentsFiles: state.attachments,
      );

      emailCubit.send(
        email: email,
        replyAll: state.replyAll,
        replyOriginalMessageId: state.originalMessage,
        reply: state.reply!,
        forward: state.forward!,
        from: emailCubit.state.currentMailBox!,
      );
      emit(state.copyWith(status: EmailSendStatus.sent));
    } else {
      emit(state.copyWith(status: EmailSendStatus.inputNotValid));
    }
  }

  String bodyHtml(QuillController controller) {
    return QuillDeltaToHtmlConverter(
            List.castFrom(controller.document.toDelta().toJson()),
            ConverterOptions.forEmail())
        .convert();
  }
}
