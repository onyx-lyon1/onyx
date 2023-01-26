import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/login/login_export.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:sizer/sizer.dart';

class EmailSendAutocompleteWidget extends StatelessWidget {
  const EmailSendAutocompleteWidget({Key? key, required this.destinationEditor})
      : super(key: key);
  final TextEditingController destinationEditor;

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (Res.mock) {
          return EmailLogic.mockAddresses;
        }
        if (!context.read<EmailCubit>().mailClient.isAuthenticated) {
          context.read<EmailCubit>().connect(
              username: context.read<AuthentificationCubit>().state.username!,
              password: context.read<AuthentificationCubit>().state.password!);
          return [];
        } else {
          return (await context
                  .read<EmailCubit>()
                  .mailClient
                  .resolveContact(textEditingValue.text))
              .map((e) => e.email.toString())
              .toList();
        }
      },
      displayStringForOption: (String option) => option,
      textEditingController: destinationEditor,
      focusNode: FocusNode(),
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            color: Theme.of(context).colorScheme.background,
            child: SizedBox(
              height: 20.h,
              child: ListView(
                padding: EdgeInsets.all(1.h),
                children: options
                    .map((String option) => GestureDetector(
                          onTap: () {
                            onSelected(option);
                          },
                          child: ListTile(
                            title: Text(option),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
        );
      },
      fieldViewBuilder: (BuildContext context,
          TextEditingController fieldTextEditingController,
          FocusNode fieldFocusNode,
          VoidCallback onFieldSubmitted) {
        return SizedBox(
          height: 4.5.h,
          child: TextField(
            controller: fieldTextEditingController,
            focusNode: fieldFocusNode,
            textAlignVertical: TextAlignVertical.top,
            cursorColor: Theme.of(context).textTheme.labelLarge!.color!,
            style: TextStyle(
              color: Theme.of(context).textTheme.labelLarge!.color!,
            ),
            decoration: InputDecoration(
                hintText:
                    "Destinataire : PXXXXXXX, prenom.nom@status.univ-lyon1.fr",
                hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withOpacity(0.5)),
                isDense: true,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).textTheme.bodyLarge!.color!,
                      width: 1),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.background,
                    width: 1,
                  ),
                )),
          ),
        );
      },
    );
  }
}
