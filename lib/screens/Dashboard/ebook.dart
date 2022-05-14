import 'package:flutter/material.dart';
import 'package:getvalue/screens/Dashboard/data/data.dart';
import 'package:getvalue/services/constants.dart';
import 'package:getvalue/size_confige.dart';

class EbookScreen extends StatefulWidget {
  const EbookScreen({Key? key}) : super(key: key);

  @override
  State<EbookScreen> createState() => _EbookScreenState();
}

class _EbookScreenState extends State<EbookScreen> {
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
                  "Ebooks",
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
                height: getRelativeHeight(0.3),
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
                          height: getRelativeHeight(0.3),
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
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: getRelativeHeight(0.15),
                                    width: getRelativeHeight(0.15),
                                    child: Image.network(
                                      category.imagepath,
                                      fit: BoxFit.cover,
                                      width: 1000.0,
                                      height: 1000,
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "12 Easy Steps To Awesome Copy",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "By Lamax Library",
                                        style: TextStyle(
                                            fontSize: 12, color: kPrimaryColor),
                                      ),
                                      Text("10000",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ],
                              )),
                        ),
                        SizedBox(width: getRelativeWidth(0.02))
                      ],
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
