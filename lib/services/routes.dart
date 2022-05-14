import 'package:flutter/widgets.dart';
import 'package:getvalue/screens/Dashboard/dashboard_screen.dart';
import 'package:getvalue/screens/login_screen/login_screen.dart';
import 'package:getvalue/screens/register/register.dart';
import 'package:getvalue/screens/splash_Screen/splash_screen.dart';

// We use named route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  Register.routeName: (context) => const Register(),
   DashBoardScreen.routeName: (context) => const DashBoardScreen(),
};
