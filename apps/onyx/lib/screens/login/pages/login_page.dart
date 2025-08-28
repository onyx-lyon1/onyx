import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1casclient/lyon1casclient.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/core/screens/privacy_policie_page.dart';
import 'package:onyx/l10n/app_localizations.dart';
import 'package:onyx/screens/login/login_export.dart';
import 'package:onyx/screens/login/pages/waiting_biometric.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../core/widgets/states_displaying/state_displaying_widget_export.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String username = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    final settings = context.read<SettingsCubit>().settings;
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return switch (state.status) {
          AuthentificationStatus.authentificating => StateDisplayingPage(
              message: AppLocalizations.of(context).authentication),
          AuthentificationStatus.authentificated => StateDisplayingPage(
              message: AppLocalizations.of(context).yourAuthentificated),
          AuthentificationStatus.error => StateDisplayingPage(
              message: AppLocalizations.of(context).loginError),
          AuthentificationStatus.waitingBiometric => const WaitingBiometric(),
          _ => Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
              resizeToAvoidBottomInset: false,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Spacer(),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 2,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(flex: 10, child: Image.asset(Res.iconPath)),
                          const Spacer(),
                          Flexible(
                            flex: 10,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppLocalizations.of(context).onyx,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .copyWith(
                                          fontSize: 20.sp,
                                        )),
                                Text(AppLocalizations.of(context).onyxSubTitle,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .copyWith(fontSize: 12.sp)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 9,
                      child: SizedBox(
                        width: (Device.orientation == Orientation.portrait)
                            ? 70.w
                            : 60.h,
                        child: Form(
                          key: _formKey,
                          child: AutofillGroup(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: AutoSizeText(
                                        AppLocalizations.of(context)
                                            .authentication,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(fontSize: 17.sp),
                                        maxLines: 1,
                                      ),
                                    ),
                                    Flexible(
                                      child: Material(
                                        borderRadius: BorderRadius.circular(5),
                                        child: OpenContainer(
                                          closedColor: Theme.of(context)
                                              .secondaryHeaderColor,
                                          openBuilder: (context, closewidget) =>
                                              const PrivacyPolicyPage(),
                                          closedBuilder:
                                              (context, openwidget) => InkWell(
                                            onTap: openwidget,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 3.w,
                                                  vertical: 0.5.h),
                                              child: AutoSizeText(
                                                AppLocalizations.of(context)
                                                    .privacy,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(fontSize: 16.sp),
                                                maxLines: 1,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Container(
                                  color: Theme.of(context).secondaryHeaderColor,
                                  child: TextFormField(
                                    autofillHints: const [
                                      AutofillHints.username
                                    ],
                                    onSaved: (String? value) => username =
                                        (RegExp(r"^([pP])\d{7}$")
                                                .hasMatch(value!.trim()))
                                            ? value
                                                .trim()
                                                .replaceFirst("p", "P")
                                            : value.trim(),
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      labelText:
                                          AppLocalizations.of(context).username,
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .color!
                                                .withValues(alpha: 0.5),
                                          ),
                                      prefixIcon: Icon(
                                        Icons.school_rounded,
                                        size: 18.sp,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .color!
                                            .withValues(alpha: 0.5),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .color!),
                                      ),
                                      disabledBorder: InputBorder.none,
                                    ),
                                    validator: (value) {
                                      if (Res.mock) {
                                        return null;
                                      }
                                      if (value == null || value.isEmpty) {
                                        return AppLocalizations.of(context)
                                            .pleaseEnterId;
                                      } else if (!RegExp(
                                              r"(^([pP])\d{7}$)|(.{2,}\..{2,})")
                                          .hasMatch(value.trim())) {
                                        return AppLocalizations.of(context)
                                            .wrongIdFormat;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Container(
                                  color: Theme.of(context).secondaryHeaderColor,
                                  child: PasswordFormField(
                                    onFieldSubmitted: send,
                                    decoration: InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .color!),
                                      ),
                                      disabledBorder: InputBorder.none,
                                    ),
                                    onSaved: (String? value) =>
                                        password = value!,
                                    // The validator receives the text that the user has entered.
                                    validator: (value) {
                                      if (Res.mock) {
                                        return null;
                                      }
                                      if (value == null || value.isEmpty) {
                                        return AppLocalizations.of(context)
                                            .pleaseEnterPassword;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                InkWell(
                                  onTap: send,
                                  child: Container(
                                    width: 70.w,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 2.h),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Text(
                                        AppLocalizations.of(context).login,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                              fontSize: 17.sp,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 2,
                      child: TextButton(
                        onPressed: () {
                          Res.mock = true;
                          context.read<SettingsCubit>().modify(
                                  settings: settings.copyWith(
                                mock: true,
                              ));
                          context.read<AuthCubit>().login(
                                settings: settings,
                              );
                        },
                        child: Text(AppLocalizations.of(context).discoverApp),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        };
      },
    );
  }

  void send() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final settingsCubit = context.read<SettingsCubit>();
      if (await context.read<AuthCubit>().login(
            creds: Credential(username, password),
            settings: settingsCubit.settings,
          )) {
        settingsCubit.modify(
            settings: settingsCubit.settings.copyWith(firstLogin: false));
      }
    }
  }
}

class PasswordFormField extends StatefulWidget {
  final FormFieldSetter<String?>? onSaved;
  final FormFieldValidator? validator;
  final InputDecoration decoration;
  final void Function() onFieldSubmitted;

  const PasswordFormField({
    super.key,
    this.onSaved,
    this.validator,
    this.decoration = const InputDecoration(),
    required this.onFieldSubmitted,
  });

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: widget.onSaved,
      validator: widget.validator,
      obscureText: _isObscure,
      autofillHints: const [AutofillHints.password],
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (String useless) => widget.onFieldSubmitted(),
      decoration: widget.decoration.copyWith(
          labelText: AppLocalizations.of(context).password,
          labelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .color!
                    .withValues(alpha: 0.5),
              ),
          prefixIcon: Icon(
            Icons.lock_rounded,
            size: 18.sp,
            color: Theme.of(context)
                .textTheme
                .bodyLarge!
                .color!
                .withValues(alpha: 0.5),
          ),
          suffixIcon: IconButton(
              icon: Icon(
                _isObscure
                    ? Icons.visibility_rounded
                    : Icons.visibility_off_rounded,
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              })),
    );
  }
}
