import 'package:getvalue/services/constants.dart';

import 'package:flutter/material.dart';
import 'package:getvalue/services/size_config.dart';

import 'package:sizer/sizer.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

//static const  heroTag='';
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70.w,
      child: Drawer(
        elevation: 20,
        child: ListView(
          children: <Widget>[
            Container(
              color: kPrimaryColor,
              child: DrawerHeader(
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(300),
                    ),
                    color: Colors.white,
                    border: Border.all(width: 1, style: BorderStyle.solid),
                  ),
                  child: Center(
                      child: Image.asset(
                    'assets/images/logo.png',
                    width: 150,
                    height: 150,
                  )),
                ),
              ),
            ),
            ListTile(
              title: const Text('Apiaries Jobs',
                  style: TextStyle(color: Colors.black)),
              leading: const Icon(
                Icons.account_circle,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
                title: const Text('Sync Data',
                    style: TextStyle(color: Colors.black)),
                leading: const Icon(
                  Icons.settings,
                  color: Colors.black,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                }),
            Container(
              height: getProportionateScreenHeight(2),
              decoration: const BoxDecoration(
                  color: Colors.black38, shape: BoxShape.rectangle),
            ),
            ListTile(
              title:
                  const Text('Settings', style: TextStyle(color: Colors.black)),
              leading: const Icon(
                Icons.more_horiz,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title:
                  const Text('Logout', style: TextStyle(color: Colors.black)),
              leading: const Icon(
                Icons.arrow_forward,
                color: Colors.black,
              ),
              onTap: () {
                // SharedPreferences.getInstance().then((prefs) {
                //   prefs.clear();
                // });
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/login', (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
