import 'dart:convert';
import 'dart:io';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:getvalue/screens/my_product/audio.dart';
import 'package:getvalue/screens/my_product/favorites.dart';
import 'package:getvalue/screens/my_product/video_product.dart';
import 'package:getvalue/services/size_config.dart';
import 'package:http/http.dart' as http;

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:getvalue/constants.dart';
import 'package:getvalue/screens/Dashboard/dashboard_screen.dart';
import 'package:getvalue/screens/my_product/ebook_product.dart';
import 'package:getvalue/services/constants.dart';
import 'package:getvalue/size_confige.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProductScreen extends StatefulWidget {
  static String routeName = "/myproduct";
  const MyProductScreen({Key? key}) : super(key: key);

  @override
  State<MyProductScreen> createState() => _MyProductScreenState();
}

class _MyProductScreenState extends State<MyProductScreen> {
  int _currentIndex = 0;
  late PageController _pageController;
  late final ScrollListener _model;
  late final ScrollController _controller;

  TextEditingController textController = TextEditingController();
  List data = [];
  bool isLoading = false;
  List dataEbook = [];
  List dataAudio = [];
  List dataVideo = [];

  Future getProducts() async {
    if (mounted) {
      setState(() {
        isLoading = true;
      });
    }
    try {
      String userEmail = await SharedPreferences.getInstance()
          .then((prefs) => prefs.getString('email').toString());
      var url = Uri.parse('$baseUrl/api/orders?email=$userEmail');
      final response = await http.get(
        url,
      );
      var res;

      // print(response.statusCode);
      // print(response.body);
      switch (response.statusCode) {
        case 200:
          if (mounted) {
            setState(() {
              res = json.decode(response.body);

              setState(() {
                if (!res["error"]) {
                  data = res["order"];
                  print(data);
                  for (var i = 0; i < data.length; i++) {
                    print("fsfds");
                    if (data[i]["product_category"] == "ebooks") {
                      print(data[i]);
                      dataEbook.add(data[i]);
                    } else if (data[i]["product_category"] == "audiobooks") {
                      print(data[i]);
                      dataAudio.add(data[i]);
                    } else {
                      print(data[i]);
                      dataVideo.add(data[i]);
                    }
                  }
                }
              });
            });
            if (mounted) {
              setState(() {
                isLoading = false;
              });
            }
          }
          break;

        case 500:
          if (mounted) {
            setState(() {
              res = response.body;
            });
          }
          break;
        default:
          if (mounted) {
            setState(() {
              res = json.decode(response.body);
              // ignore: avoid_print
              print(res);
            });
          }
          break;
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          var res = 'Server Error';

          print(e.toString());
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    getProducts();
    _controller = ScrollController();
    _model = ScrollListener.initialise(_controller);
  }

  // getRole() async {
  //   role = await SharedPreferences.getInstance()
  //       .then((value) => value.getString('type'));
  // }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  dashboard() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: const [Text("jdbcjdbcj")],
        ),
      ),
    );
  }

  message(String hint, String message) {
    return Alert(
      context: context,
      type: hint == "info" ? AlertType.info : AlertType.success,
      title: "",
      desc: message,
      buttons: [
        DialogButton(
          color: Colors.red,
          radius: const BorderRadius.all(Radius.circular(10)),
          child: const Text(
            "Ok",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/login', (Route<dynamic> route) => false);
          },
          width: 120,
        ),
        DialogButton(
          color: Colors.green,
          radius: const BorderRadius.all(Radius.circular(10)),
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            Navigator.pop(context);
          },
          width: 120,
        )
      ],
    ).show();
  }

  Future<bool> _willPopCallback() async {
    message("info", "Are You Sure You Want To Exit");
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _willPopCallback,
        child: Scaffold(
          backgroundColor: kBackgroundColor,
          body: isLoading
              ? SizedBox(
                  height: getProportionateScreenHeight(300),
                  child: const Center(
                      child: SpinKitCircle(
                    color: kPrimaryColor,
                  )))
              : AnimatedBuilder(
                  animation: _model,
                  builder: (context, child) {
                    return SizedBox.expand(
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (index) {
                          if (mounted) {
                            setState(() => _currentIndex = index);
                          }
                        },
                        children: <Widget>[
                          MyEbooks(data: dataEbook),
                          AudioProduct(
                            data: dataAudio,
                          ),
                          VideoProduct(
                            data: dataVideo,
                          ),
                          const Favorites(),
                          const DashBoardScreen(),
                        ],
                      ),
                    );
                  }),
          bottomNavigationBar: BottomNavyBar(
            showElevation: true,
            selectedIndex: _currentIndex,
            onItemSelected: (index) {
              if (mounted) {
                setState(() => _currentIndex = index);
              }
              _pageController.jumpToPage(index);
            },
            items: <BottomNavyBarItem>[
              BottomNavyBarItem(
                  activeColor: kPrimaryColor,
                  inactiveColor: Colors.black,
                  title: const Text(
                    'eBook',
                    style: TextStyle(color: Colors.black),
                  ),
                  icon: const Icon(
                    Icons.book_rounded,
                    color: Colors.black,
                  )),
              BottomNavyBarItem(
                  activeColor: kPrimaryColor,
                  inactiveColor: Colors.grey[600],
                  title: const Text('Audio Books',
                      style: TextStyle(color: Colors.black)),
                  icon: const Icon(
                    Icons.headphones,
                    color: Colors.black,
                  )),
              BottomNavyBarItem(
                  activeColor: kPrimaryColor,
                  inactiveColor: Colors.grey[600],
                  title: const Text('Trainings',
                      style: TextStyle(color: Colors.black)),
                  icon: const Icon(
                    Icons.ondemand_video_outlined,
                    color: Colors.black,
                  )),
              BottomNavyBarItem(
                  activeColor: kPrimaryColor,
                  inactiveColor: Colors.grey[600],
                  title: const Text('Favorites',
                      style: TextStyle(color: Colors.black)),
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.black,
                  )),
              BottomNavyBarItem(
                  activeColor: kPrimaryColor,
                  inactiveColor: Colors.grey[600],
                  title:
                      const Text('shop', style: TextStyle(color: Colors.black)),
                  icon: const Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                  )),
            ],
          ),
        ));
  }
}

class ScrollListener extends ChangeNotifier {
  double bottom = 0;
  double _last = 0;

  ScrollListener.initialise(ScrollController controller, [double height = 56]) {
    controller.addListener(() {
      final current = controller.offset;
      bottom += _last - current;
      if (bottom <= -height) bottom = -height;
      if (bottom >= 0) bottom = 0;
      _last = current;
      if (bottom <= 0 && bottom >= -height) notifyListeners();
    });
  }
}
