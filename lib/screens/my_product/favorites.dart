import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        child: Icon(
          Icons.favorite,
          size: 50.sp,
          color: Colors.grey,
        ),
      )),
    );
  }
}
