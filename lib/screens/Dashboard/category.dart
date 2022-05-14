import 'package:flutter/material.dart';
import 'package:getvalue/screens/Dashboard/data/category.dart';
import 'package:getvalue/screens/Dashboard/data/data.dart';
import 'package:getvalue/services/constants.dart';
import 'package:getvalue/size_confige.dart';

class Category extends StatefulWidget {
  const Category({
    Key? key,
  }) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      // height: getRelativeHeight(0.09),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: getRelativeWidth(0.009),
                  height: getRelativeHeight(0.07),
                  color: kPrimaryColor,
                ),
                SizedBox(
                  width: getRelativeWidth(0.05),
                ),
                const Text(
                  "Category",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                const Text(
                  "View All",
                  style: TextStyle(color: kPrimaryColor),
                ),
                SizedBox(
                  width: getRelativeWidth(0.05),
                ),
              ],
            ),
            SizedBox(
              height: getRelativeHeight(0.01),
            ),
            Container(
                height: getRelativeHeight(0.2),
                child: ListView.builder(
                  itemCount: Data.categoriesList.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(
                      horizontal: getRelativeWidth(0.005),
                      vertical: getRelativeWidth(0.010)),
                  itemBuilder: (context, index) {
                    final category = Data.categoriesList[index];
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: getRelativeHeight(0.2),
                          width: getRelativeHeight(0.15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.black, kPrimaryLightColor],
                            ),
                          ),
                          child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                              child: Stack(
                                children: <Widget>[
                                  Image.network(
                                    category.imagepath,
                                    fit: BoxFit.cover,
                                    width: 1000.0,
                                    height: 1000,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            category.title,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              // fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            category.subtitle,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              // fontSize: 15.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        SizedBox(width: getRelativeWidth(0.02))
                      ],
                    );
                  },
                ))
          ],
        ),
      ),
    );
  }
}
