import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oloid2/states/authentification/authentification_bloc.dart';
import 'package:oloid2/states/settings/settings_bloc.dart';
import 'package:oloid2/widget/state_displaying.dart';
import 'package:sizer/sizer.dart';

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
    AuthentificationState state = context.read<AuthentificationBloc>().state;
    if (state is AuthentificationInitial) {
      context.read<AuthentificationBloc>().add(AuthentificationLogin(
          keepLogedIn: context.read<SettingsBloc>().settings.keepMeLoggedIn));
      return const StateDisplaying(message: "Start authentification");
    } else if (state is AuthentificationAuthentificating) {
      return const StateDisplaying(message: "Authentificating");
    } else if (state is AuthentificationError) {
      Future.delayed(const Duration(seconds: 1), () {
        context.read<AuthentificationBloc>().add(AuthentificationLogout());
      });
      return const StateDisplaying(message: "Login error");
    } else if (state is AuthentificationNeedCredential) {
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
                      // The validator receives the text that the user has entered.
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
      return const StateDisplaying(message: "Doing something");
    }
  }

  void send() async {
    // Validate returns true if the form is valid, or false otherwise.
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      _formKey.currentState!.save();
      context.read<AuthentificationBloc>().add(AuthentificationLogin(
          username: username,
          password: password,
          keepLogedIn: context.read<SettingsBloc>().settings.keepMeLoggedIn));
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
          // this button is used to toggle the password visibility
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
