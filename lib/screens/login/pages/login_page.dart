import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oloid2/screens/login/login_export.dart';
import 'package:oloid2/screens/settings/settings_export.dart';
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
    } else if (state.status == AuthentificationStatus.error) {
      Future.delayed(const Duration(seconds: 1), () {
        context.read<AuthentificationCubit>().logout();
      });
      return const StateDisplayingPage(message: "Login error");
    } else if (state.status == AuthentificationStatus.needCredential) {
      return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Form(
          key: _formKey,
          child: Center(
            child: AutofillGroup(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Authentification",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontSize: 20.sp),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Container(
                    color: Theme.of(context).cardTheme.color,
                    width: 70.w,
                    child: TextFormField(
                      autofillHints: const [AutofillHints.username],
                      onSaved: (String? value) =>
                          username = value!.replaceFirst("p", "P"),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Theme.of(context).primaryColor),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Theme.of(context).primaryColor)),
                        disabledBorder: InputBorder.none,
                      ),
                      validator: (value) {
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
                    color: Theme.of(context).cardTheme.color,
                    width: 70.w,
                    child: PasswordFormField(
                      onFieldSubmitted: send,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 2,
                                color: Theme.of(context).primaryColor)),
                        disabledBorder: InputBorder.none,
                      ),
                      onSaved: (String? value) => password = value!,
                      // The validator receives the text that the user has entered.
                      validator: (value) {
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
                  ElevatedButton(
                    onPressed: send,
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Theme.of(context).primaryColor)),
                    child: const Text(
                      'Connection',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return const StateDisplayingPage(message: "Doing something");
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
          labelStyle: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Theme.of(context).primaryColor),
          suffixIcon: IconButton(
              icon: Icon(
                _isObscure ? Icons.visibility : Icons.visibility_off,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              })),
    );
  }
}
