import 'dart:async';

import 'package:getvalue/screens/login_screen/login_screen.dart';
import 'package:getvalue/services/size_config.dart';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 5), () async {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.camera,
        Permission.storage,
        Permission.photos,
        Permission.accessMediaLocation,

        Permission.manageExternalStorage
        //add more permission to request here.
      ].request();

      // if (statuses[Permission.location]!.isDenied) {
      //   //check each permission status after.
      //   print("Location permission is denied.");
      // }

      // if (statuses[Permission.camera]!.isDenied) {
      //   //check each permission status after.
      //   print("Camera permission is denied.");
      // }
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Image.asset(
                      "assets/images/logo.png",
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
