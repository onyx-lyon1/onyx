import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:onyx/screens/settings/states/settings_cubit.dart';
import 'package:sizer/sizer.dart';

class MailSendAutocompleteWidget extends StatelessWidget {
  const MailSendAutocompleteWidget({Key? key, required this.destinationEditor})
      : super(key: key);
  final TextEditingController destinationEditor;

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) async {
        if (Res.mock) {
          return MailLogic.mockAddresses;
        }
        if (!context.read<EmailCubit>().mailClient!.isAuthenticated) {
          Credential? creds = await CacheService.get<Credential>(
              secureKey: await CacheService.getEncryptionKey(
                  context.read<SettingsCubit>().state.settings.biometricAuth));
          if (creds != null) {
            // ignore: use_build_context_synchronously
            context
                .read<EmailCubit>()
                .connect(username: creds.username, password: creds.password);
          }
          return [];
        } else {
          return (await context
                  .read<EmailCubit>()
                  .mailClient!
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
