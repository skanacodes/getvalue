import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:getvalue/screens/splash_Screen/splash_screen.dart';
import 'package:getvalue/size_confige.dart';

import 'package:sizer/sizer.dart';

import 'package:getvalue/services/routes.dart';
import 'package:getvalue/services/theme.dart';

const simplePeriodicTask = "simplePeriodicTask";

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Timer? _timer;
  bool forceLogout = false;
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    _initializeTimer();
  }

  void _initializeTimer() {
    _timer = Timer.periodic(const Duration(minutes: 5), (_) => _logOutUser());
  }

  void _logOutUser() {
    // Log out the user if they're logged in, then cancel the timer.
    // You'll have to make sure to cancel the timer if the user manually logs out
    //   and to call _initializeTimer once the user logs in
    _timer!.cancel();
    setState(() {
      forceLogout = false;
    });
  }

  // You'll probably want to wrap this function in a debounce
  void _handleUserInteraction([_]) {
    // print("_handleUserInteraction");
    _timer!.cancel();
    _initializeTimer();
  }

  void navToHomePage(BuildContext context) {
    // navigatorKey.currentState!.pushAndRemoveUntil(
    //     MaterialPageRoute(builder: (context) => const LoginScreen()),
    //     (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    // if (forceLogout) {
    //   print("ForceLogout is $forceLogout");
    //   navToHomePage(context);
    // }
    return Sizer(builder: (context, orientation, deviceType) {
      return GestureDetector(
        onTap: _handleUserInteraction,
        onPanDown: _handleUserInteraction,
        onScaleStart: _handleUserInteraction,
        child: MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'GetValue',
          theme: theme(),

          home: Builder(builder: (context) {
            SizeConfig.initSize(context);

            return const SplashScreen();
          }),
          // We use routeName so that we dont need to remember the name
          //initialRoute: SplashScreen.routeName,
          routes: routes,
        ),
      );
    });
  }
}
