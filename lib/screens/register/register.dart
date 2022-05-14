// ignore_for_file: unused_element, body_might_complete_normally_nullable

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:getvalue/screens/login_screen/login_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:getvalue/services/constants.dart';
import 'package:getvalue/size_confige.dart';

class Register extends StatefulWidget {
  static String routeName = "/register";
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool remembervalue = false;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? username;
  String? phoneNumber;
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

  Future<String> registerUser() async {
    try {
      var url = Uri.parse('$baseUrl/app/user/register_customer');

      final response = await http.post(
        url,
        body: {
          'surname': "sikana",
          'password': password,
          'first_name': name,
          'email': username,
          'phone': phoneNumber
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

  Widget _submitButton() {
    return InkWell(
      onTap: () async {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          print(username);
          print(password);
          print(name);
          print(phoneNumber);

          await registerUser();
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
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Text(
                    'REGISTER',
                    style: TextStyle(fontSize: 13.0.sp, color: Colors.white),
                  ),
                ),
              ),
            ),
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
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  //  height: getRelativeHeight(0.8),
                  width: double.infinity,
                  color: Colors.black,
                  child: AnimationLimiter(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                          SizedBox(
                            height: getRelativeHeight(0.04),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
                            child: Text(
                              "Sign Up",
                              style: TextStyle(fontSize: 20.sp),
                            ),
                          ),
                          SizedBox(
                            height: getRelativeHeight(0.1),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, right: 20, left: 20),
                            child: SizedBox(
                              child: TextFormField(
                                style: const TextStyle(color: Colors.white),
                                keyboardType: TextInputType.text,
                                key: const Key("email"),
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                  ),
                                  hintStyle: TextStyle(color: Colors.white),
                                  hintText: "Name",
                                  filled: true,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "This Field Is Required";
                                  }
                                },
                                onSaved: (value) {
                                  name = value;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, right: 20, left: 20),
                            child: SizedBox(
                              child: TextFormField(
                                style: const TextStyle(color: Colors.white),
                                keyboardType: TextInputType.emailAddress,
                                key: const Key("email"),
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.email_outlined,
                                    color: Colors.white,
                                  ),
                                  hintStyle: TextStyle(color: Colors.white),
                                  hintText: "Email",
                                  filled: true,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "This Field Is Required";
                                  }
                                },
                                onSaved: (value) {
                                  username = value;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, right: 20, left: 20),
                            child: SizedBox(
                              child: TextFormField(
                                style: const TextStyle(color: Colors.white),
                                keyboardType: TextInputType.phone,
                                key: const Key(""),
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.phone_android_outlined,
                                    color: Colors.white,
                                  ),
                                  hintStyle: TextStyle(color: Colors.white),
                                  hintText: "Phone Number",
                                  filled: true,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "This Field Is Required";
                                  }
                                },
                                onSaved: (value) {
                                  phoneNumber = value;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 10, right: 20, left: 20),
                            child: SizedBox(
                              child: TextFormField(
                                style: const TextStyle(color: Colors.white),
                                keyboardType: TextInputType.text,
                                key: const Key(""),
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: Colors.white,
                                  ),
                                  hintStyle: TextStyle(color: Colors.white),
                                  hintText: "Password",
                                  filled: true,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "This Field Is Required";
                                  }
                                },
                                onSaved: (value) {
                                  password = value;
                                },
                              ),
                            ),
                          ),
                          _submitButton(),
                          InkWell(
                            onTap: () => Navigator.pushNamed(
                                context, LoginScreen.routeName),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: getRelativeWidth(0.1),
                                ),
                                const Text(
                                  'Already Have An Account? ',
                                  style: TextStyle(color: Colors.white),
                                ),
                                const Text(
                                  ' Login ',
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                  ),
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
      ),
    );
  }
}
