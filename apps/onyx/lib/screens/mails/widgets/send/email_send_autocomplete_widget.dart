import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:onyx/core/cache_service.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/l10n/app_localizations.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:onyx/screens/settings/states/settings_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MailSendAutocompleteWidget extends StatelessWidget {
  const MailSendAutocompleteWidget(
      {super.key, required this.destinationEditor});

  final TextEditingController destinationEditor;

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (Res.mock) {
          return MailLogic.mockAddresses;
        }
        final emailCubit = context.read<EmailCubit>();
        final localization = AppLocalizations.of(context);
        if (!context.read<EmailCubit>().mailClient!.isAuthenticated) {
          CacheService.getEncryptionKey(
                  context.read<SettingsCubit>().settings.biometricAuth)
              .then((encryptionKey) =>
                  CacheService.get<Credential>(secureKey: encryptionKey))
              .then(
            (credentials) {
              if (credentials != null) {
                emailCubit.connect(
                  username: credentials.username,
                  password: credentials.password,
                  appLocalizations: localization,
                );
              }
            },
          );

          return [];
        } else {
          return context
              .read<EmailCubit>()
              .mailClient!
              .resolveContact(textEditingValue.text)
              .then((e) => e.map((e) => e.email.toString()).toList());
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
            color: Theme.of(context).colorScheme.surface,
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
                hintText: AppLocalizations.of(context).emailAddressHint,
                hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .color!
                        .withValues(alpha: 0.5)),
                isDense: true,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).textTheme.bodyLarge!.color!,
                      width: 1),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.surface,
                    width: 1,
                  ),
                )),
          ),
        );
      },
    );
  }
}
