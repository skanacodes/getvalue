import 'package:flutter/material.dart';
import 'package:getvalue/services/constants.dart';
import 'package:getvalue/size_confige.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({Key? key}) : super(key: key);

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
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
                  "Trending",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
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
                  itemCount: 5,
                  shrinkWrap: true,
                  // scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(
                      horizontal: getRelativeWidth(0.005),
                      vertical: getRelativeWidth(0.010)),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Kutoka Sifuri Mpaka Kileleni"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8, right: 8),
                          child: Divider(
                            color: Colors.white,
                          ),
                        )
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
