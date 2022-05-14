import 'package:flutter/material.dart';

class CategoryModel {
  final String title;
  final String subtitle;
  final IconData icon;
  final String imagepath;

  CategoryModel(
      {required this.title,
      required this.subtitle,
      required this.icon,
      required this.imagepath});
}
