import 'package:flutter/material.dart';

import 'package:getvalue/screens/Dashboard/data/category.dart';

class Data {
  static final categoriesList = [
    // ignore: prefer_const_constructors

    CategoryModel(
      title: "Ebooks",
      subtitle: "(407) Product",
      icon: Icons.line_style,
      imagepath:
          'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    ),
    CategoryModel(
      title: "  Audiobooks",
      subtitle: "(23) Products",
      icon: Icons.supervised_user_circle_outlined,
      imagepath:
          'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    ),
    CategoryModel(
        title: "Online Training & Programs",
        subtitle: "(21) Product",
        icon: Icons.supervised_user_circle_outlined,
        imagepath:
            'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'),
  ];

  // static final auctionsList = [
  //   Auction(
  //       name: "Longuza Teak Auction December 2021",
  //       speciality: "Pending",
  //       reviews: 80,
  //       reviewScore: 4),
  //   Auction(
  //       name: "Mtibwa Teak Auction December 2021",
  //       speciality: "Complete",
  //       reviews: 67,
  //       reviewScore: 5),
  //   Auction(
  //       name: "Longuza Teak Auction December 2021",
  //       speciality: "Complete",
  //       reviews: 19,
  //       reviewScore: 3),
  // ];
}
