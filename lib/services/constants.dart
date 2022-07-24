import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:getvalue/services/size_config.dart';

const kPrimaryColor = Color(0xFFDEBE67);
const kPrimaryLightColor = Color.fromARGB(255, 2, 2, 2);
// const kPrimaryGradientColor = LinearGradient(
//   begin: Alignment.topLeft,
//   end: Alignment.bottomRight,
//   colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
// );
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color.fromARGB(255, 240, 233, 233);

const kAnimationDuration = Duration(milliseconds: 200);
const baseUrl = "https://www.getvalue.co";

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);
final formatNumber = NumberFormat("#,##0.00", "en_US");
const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";
const String authkey = "b81bd363b70fb1a6e921150a4df6413d";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: const BorderSide(color: Colors.cyan),
  );
}
