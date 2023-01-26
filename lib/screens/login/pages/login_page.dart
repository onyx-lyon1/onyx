import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/screens/login/login_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:sizer/sizer.dart';

import '../../../core/widgets/states_displaying/state_displaying_widget_export.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String username = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    AuthentificationState state = context.read<AuthentificationCubit>().state;
    if (state.status == AuthentificationStatus.initial) {
      context.read<AuthentificationCubit>().login(
          keepLogedIn:
              context.read<SettingsCubit>().state.settings.keepMeLoggedIn);
      return const StateDisplayingPage(message: "Start authentification");
    } else if (state.status == AuthentificationStatus.authentificating) {
      return const StateDisplayingPage(message: "Authentification");
    } else if (state.status == AuthentificationStatus.error &&
        context.read<AuthentificationCubit>().state.firstLogin) {
      Future.delayed(const Duration(seconds: 1), () {
        context.read<AuthentificationCubit>().logout();
      });
      return const StateDisplayingPage(message: "Login error");
    } else if (state.status == AuthentificationStatus.needCredential) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 40.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icon.png",
                    width: 25.w,
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("ONYX",
                          style:
                              Theme.of(context).textTheme.displayLarge!.copyWith(
                                    fontSize: 20.sp,
                                  )),
                      Text("Pour Lyon 1",
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium!
                              .copyWith(fontSize: 8.sp)),
                    ],
                  ),
                ],
              ),
            ),
            Form(
              key: _formKey,
              child: AutofillGroup(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 70.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Authentification",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontSize: 12.sp),
                          ),
                          Material(
                            color: Theme.of(context).secondaryHeaderColor,
                            borderRadius: BorderRadius.circular(5),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(5),
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 3.w, vertical: 0.5.h),
                                child: Text(
                                  "confidentialité",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontSize: 10.sp),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      color: Theme.of(context).secondaryHeaderColor,
                      width: 70.w,
                      child: TextFormField(
                        autofillHints: const [AutofillHints.username],
                        onSaved: (String? value) =>
                            username = value!.replaceFirst("p", "P"),
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          labelStyle:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color!
                                        .withOpacity(0.5),
                                  ),
                          prefixIcon: Icon(
                            Icons.school_rounded,
                            size: 18.sp,
                            color: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .color!
                                .withOpacity(0.5),
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
                            return 'Veuillez entrer l\'identifiant';
                          } else if (!(value.startsWith("P") ||
                              value.startsWith("p"))) {
                            return "l'identifiant doit commencer par P";
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      color: Theme.of(context).secondaryHeaderColor,
                      width: 70.w,
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
                        onSaved: (String? value) => password = value!,
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (Res.mock) {
                            return null;
                          }
                          if (value == null || value.isEmpty) {
                            return 'Veuillez entrer un mot de passe';
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
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Text(
                            'Connection',
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 12.sp,
                                    ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return const StateDisplayingPage(message: "FATAL ERROR");
    }
  }

  void send() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.read<AuthentificationCubit>().login(
          username: username,
          password: password,
          keepLogedIn:
              context.read<SettingsCubit>().state.settings.keepMeLoggedIn);
    }
  }
}

class PasswordFormField extends StatefulWidget {
  final FormFieldSetter<String?>? onSaved;
  final FormFieldValidator? validator;
  final InputDecoration decoration;
  final void Function() onFieldSubmitted;

  const PasswordFormField({
    Key? key,
    this.onSaved,
    this.validator,
    this.decoration = const InputDecoration(),
    required this.onFieldSubmitted,
  }) : super(key: key);

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
          labelText: 'Password',
          labelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .color!
                    .withOpacity(0.5),
              ),
          prefixIcon: Icon(
            Icons.lock_rounded,
            size: 18.sp,
            color:
                Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.5),
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
