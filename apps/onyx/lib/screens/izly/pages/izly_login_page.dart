import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:izlyclient/izlyclient.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/core/screens/privacy_policie_page.dart';
import 'package:onyx/screens/izly/izly_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class IzlyLoginPage extends StatefulWidget {
  const IzlyLoginPage({Key? key}) : super(key: key);

  @override
  State<IzlyLoginPage> createState() => _IzlyLoginPageState();
}

class _IzlyLoginPageState extends State<IzlyLoginPage> {
  final _formKey = GlobalKey<FormState>();
  String username = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/izly.png",
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
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
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
                              .copyWith(fontSize: 18.sp),
                        ),
                        Material(
                          borderRadius: BorderRadius.circular(5),
                          child: OpenContainer(
                            closedColor: Theme.of(context).secondaryHeaderColor,
                            openBuilder: (context, closewidget) =>
                                const PrivacyPolicyPage(),
                            closedBuilder: (context, openwidget) => InkWell(
                              onTap: openwidget,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 3.w, vertical: 0.5.h),
                                child: Text(
                                  "confidentialité",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(fontSize: 17.sp),
                                ),
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
                      onSaved: (String? value) => username = value!,
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
                        } else if (!(RegExp(
                                r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                            .hasMatch(value))) {
                          return "Veuillez entrer un Mail valide";
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
                        if (int.tryParse(value) == null) {
                          return "Le mot de passe doit être un nombre";
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
                          'Connexion',
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 18.sp,
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
  }

  void send() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      context.read<IzlyCubit>().connect(
          credential: IzlyCredential(username: username, password: password),
          settings: context.read<SettingsCubit>().state.settings);
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
      keyboardType: TextInputType.number,
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
