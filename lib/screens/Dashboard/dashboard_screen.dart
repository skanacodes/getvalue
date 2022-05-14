import 'package:flutter/material.dart';
import 'package:getvalue/screens/Dashboard/category.dart';
import 'package:getvalue/screens/Dashboard/drawer.dart';
import 'package:getvalue/screens/Dashboard/ebook.dart';
import 'package:getvalue/screens/Dashboard/image_slider.dart';
import 'package:getvalue/screens/Dashboard/search_field.dart';
import 'package:getvalue/screens/Dashboard/trending.dart';
import 'package:getvalue/services/constants.dart';
import 'package:getvalue/size_confige.dart';

class DashBoardScreen extends StatelessWidget {
  static String routeName = "/Dashboard";
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryLightColor,
      drawer: const CustomDrawer(),
      appBar: AppBar(
          // leading: Builder(
          //   builder: (BuildContext context) {
          //     return IconButton(
          //       icon: const Icon(
          //         Icons.line_style_outlined,
          //         color: Colors.red, // Change Custom Drawer Icon Color
          //       ),
          //       onPressed: () {
          //         Scaffold.of(context).openDrawer();
          //       },
          //       tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          //     );
          //   },
          // ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          title: Center(
            child: SizedBox(
                height: getRelativeHeight(0.12),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    "assets/images/logo.png",
                  ),
                )),
          ),
          backgroundColor: kPrimaryLightColor,
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [Icon(Icons.shopping_cart, color: Colors.white)],
            ),
          ]),
      body: SingleChildScrollView(
          child: Column(children: const [
        SearchField(),
        ImageSlider(),
        Category(),
        EbookScreen(),
        TrendingScreen()
      ])),
    );
  }
}
