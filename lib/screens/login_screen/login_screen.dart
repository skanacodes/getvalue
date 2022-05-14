// ignore_for_file: unused_element, avoid_print

import 'dart:convert';
import 'package:getvalue/screens/Dashboard/dashboard_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:getvalue/screens/register/register.dart';
import 'package:getvalue/services/constants.dart';
import 'package:getvalue/size_confige.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  final _formKey = GlobalKey<FormState>();
  String? password;
  String auth = '';
  String? role;

  final List<String> errors = [];

  Future<void> createUser(
      String token,
      int userId,
      int stationId,
      String checkpointId,
      String fname,
      String lname,
      String email,
      String phoneNumber,
      String stationName,
      String checkpointName) async {
    await SharedPreferences.getInstance().then((prefs) {
      prefs.setInt('user_id', userId);
      prefs.setString('token', token);
      prefs.setInt('station_id', stationId);
      prefs.setString('StationName', stationName);
      prefs.setString('fname', fname);
      prefs.setString('lname', lname);
      prefs.setString('email', email);
      prefs.setString('phoneNumber', phoneNumber);
      prefs.setString('checkpointId', checkpointId);
      prefs.setString('checkpointName', checkpointName);
    });
  }

  Future<String> loginAuth() async {
    try {
      var url = Uri.parse('$baseUrl/app/api/authenticate');

      final response = await http.post(
        url,
        body: {
          'username': username,
          'password': password,
        },
      );
      var res;
      //final sharedP prefs=await
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          setState(() {
            res = json.decode(response.body);
            print(res);
          });

          await createUser(
            res['access_token'],
            res['user']['user_id'],
            res['user']['station_id'],
            res['user']['checkpoint_id'].toString(),
            res['user']['first_name'],
            res['user']['last_name'],
            res['user']['email'].toString(),
            res['user']['phone'].toString(),
            res['user']['station'].toString(),
            res['user']['checkpoint_name'].toString(),
          );
          return 'success';
          // ignore: dead_code
          break;
        case 403:
          setState(() {
            res = json.decode(response.body);
            print(res);
            if (res['message'] == 'Invalid Credentials') {
              addError(error: 'Incorrect Password or Email');
            } else if (res['message'] ==
                'Your Device Is Locked Please Contact User Support Team') {
              addError(
                  error:
                      'Your Device Is Locked Please Contact User Support Team');
            }

            isLoading = false;
          });
          return 'fail';
          // ignore: dead_code
          break;

        case 1200:
          setState(() {
            res = json.decode(response.body);
            print(res);
            addError(
                error:
                    'Your Device Is Locked Please Contact User Support Team');
          });
          return 'fail';
          // ignore: dead_code
          break;

        default:
          setState(() {
            res = json.decode(response.body);
            print(res);
            addError(error: 'Something Went Wrong');
            isLoading = false;
          });
          return 'fail';
          // ignore: dead_code
          break;
      }
    } catch (e) {
      setState(() {
        print(e);

        addError(error: 'Server Or Network Connectivity Error');
        isLoading = false;
      });
      return 'fail';
    }
  }

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
      onTap: () async {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          // print(username);
          // print(password);

          // await loginAuth();
          Navigator.of(context).pushNamed(DashBoardScreen.routeName);
        }
      },
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
                child: Form(
                  key: _formKey,
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
                          padding: const EdgeInsets.only(
                              top: 10, right: 20, left: 20),
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
                                contentPadding:
                                    EdgeInsets.fromLTRB(5, 10, 15, 2),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "This Field Is Required";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                setState(() {
                                  username = value!;
                                });
                              },
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  errors.contains('Network Problem')
                                      ? removeError(
                                          error:
                                              'Server Or Network Connectivity Error')
                                      : errors.contains(
                                              'Incorrect Password or Email')
                                          ? removeError(
                                              error:
                                                  'Incorrect Password or Email')
                                          : removeError(
                                              error:
                                                  'Your Not Authourized To Use This App');
                                }
                                return;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: getRelativeHeight(0.02),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, right: 20, left: 20),
                          child: SizedBox(
                            child: TextFormField(
                              obscureText: true,
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
                                contentPadding:
                                    EdgeInsets.fromLTRB(5, 10, 15, 2),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "This Field Is Required";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                setState(() {
                                  password = value!;
                                });
                              },
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  errors.contains('Network Problem')
                                      ? removeError(
                                          error:
                                              'Server Or Network Connectivity Error')
                                      : errors.contains(
                                              'Incorrect Password or Email')
                                          ? removeError(
                                              error:
                                                  'Incorrect Password or Email')
                                          : removeError(
                                              error:
                                                  'Your Not Authourized To Use This App');
                                }
                                return;
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, right: 17, left: 20),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
