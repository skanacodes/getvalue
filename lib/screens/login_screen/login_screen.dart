// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:getvalue/screens/register/register.dart';
import 'package:getvalue/services/constants.dart';
import 'package:getvalue/size_confige.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = "/login";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool remembervalue = false;
  bool isLoading = false;
  String? username;

  String? password;
  String auth = '';
  String? role;

  final List<String> errors = [];

  void addError({required String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({required String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () async {},
      child: isLoading
          ? SpinKitFadingCircle(
              color: kPrimaryColor,
              size: 35.0.sp,
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.shade200,
                        offset: const Offset(2, 14),
                        blurRadius: 5,
                        spreadRadius: 2)
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 13.0.sp, color: Colors.white),
                  ),
                ),
              ),
            ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Username"),
        _entryField("Password", isPassword: true),
      ],
    );
  }

  Widget _entryField(String title, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            TextFormField(
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    errors.contains('Network Problem')
                        ? removeError(
                            error: 'Server Or Network Connectivity Error')
                        : errors.contains('Incorrect Password or Email')
                            ? removeError(error: 'Incorrect Password or Email')
                            : removeError(
                                error: 'Your Not Authourized To Use This App');
                  }
                  return;
                },
                validator: (value) =>
                    value == '' ? 'This  Field Is Required' : null,
                // isPassword
                //     ? null
                //     : emailValidatorRegExp.hasMatch(value!)
                //         ? null
                //         : 'Enter Valid Email',
                onSaved: (value) {
                  setState(() {
                    isPassword ? password = value! : username = value!;
                  });
                },
                keyboardType: TextInputType.emailAddress,
                cursorColor: kPrimaryColor,
                obscureText: isPassword,
                decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(30, 20, 20, 10),
                    border: InputBorder.none,
                    fillColor: Color(0xfff3f3f4),
                    filled: true))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: getRelativeHeight(0.35),
                color: Colors.black,
                child: AnimationLimiter(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 675),
                      childAnimationBuilder: (widget) => SlideAnimation(
                        horizontalOffset: 50.0,
                        child: FadeInAnimation(
                          child: widget,
                        ),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                          child: Text(
                            "Welcome",
                            style: TextStyle(fontSize: 20.sp),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 30),
                          child: Text(
                            "Read, Listen and watch unlimited number of eBooks, audio Books and Training",
                            style: TextStyle(fontSize: 12.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              AnimationLimiter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 675),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      horizontalOffset: 50.0,
                      child: FadeInAnimation(
                        child: widget,
                      ),
                    ),
                    children: [
                      SizedBox(
                        height: getRelativeHeight(0.04),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, right: 20, left: 20),
                        child: SizedBox(
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            key: const Key("email"),
                            decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black38),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black87),
                              ),
                              // fillColor: const Color(0xfff3f3f4),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: "Email Address",
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.fromLTRB(5, 10, 15, 2),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "This Field Is Required";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: getRelativeHeight(0.02),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, right: 20, left: 20),
                        child: SizedBox(
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            key: const Key("pwd"),
                            decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black38),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black87),
                              ),
                              // fillColor: Color(0xfff3f3f4),
                              fillColor: Colors.white,
                              filled: true,
                              labelText: "Password",
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.fromLTRB(5, 10, 15, 2),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "This Field Is Required";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, right: 17, left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Checkbox(
                                checkColor: Colors.white,
                                focusColor: Colors.black,
                                value: remembervalue,
                                onChanged: (value) {
                                  setState(() {
                                    remembervalue = value!;
                                  });
                                },
                              ),
                            ), //SizedBox
                            const Expanded(
                              flex: 5,
                              child: Text(
                                'Remember Me',
                                style: TextStyle(color: Colors.black87),
                              ),
                            ), //Text
                            const Spacer(),
                            const Expanded(
                              flex: 6,
                              child: Text(
                                'Forgot Your Password?',
                                style: TextStyle(color: Colors.black87),
                              ),
                            ),
                          ], //<Widget>[]
                        ),
                      ),
                      _submitButton(),
                      InkWell(
                        onTap: () =>
                            Navigator.pushNamed(context, Register.routeName),
                        child: Row(
                          children: [
                            SizedBox(
                              width: getRelativeWidth(0.1),
                            ),
                            const Text(
                              'Don\'t have an account? ',
                              style: TextStyle(color: Colors.black87),
                            ),
                            const Text(
                              ' Sign Up ',
                              style: TextStyle(color: kPrimaryColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
