import 'package:getvalue/screens/my_product/product_details.dart';
import 'package:getvalue/services/size_config.dart';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class VideoProduct extends StatefulWidget {
  final List? data;
  const VideoProduct({Key? key, this.data}) : super(key: key);

  @override
  State<VideoProduct> createState() => _VideoProductState();
}

class _VideoProductState extends State<VideoProduct> {
  final double _bottomNavBarHeight = 56;
  TextEditingController textController = TextEditingController();
  List data = [];

  // Future getProducts() async {
  //   setState(() {
  //     print(widget.data);
  //     data = widget.data!;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    //  getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              //leading: const Expanded(flex: 2, child: Text("eBooks")),
              title: const Text(
                "Training",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.black,
              //title: const Text("eBooks"),
              actions: const [
                Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
              ],
            ),
            body: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, crossAxisSpacing: 5, mainAxisSpacing: 5),
                itemCount: widget.data!.length,
                itemBuilder: (_, i) => InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetails(
                                      product: [widget.data![i]],
                                    )));
                      },
                      child: Stack(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width,
                              height: getProportionateScreenHeight(250),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey[200]!)),
                              child: Image.network(
                                widget.data![i]["product_cover"],
                                fit: BoxFit.fill,
                              )),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 13.sp,
                                backgroundColor: Colors.black.withOpacity(0.5),
                                child: Icon(
                                  Icons.ondemand_video_outlined,
                                  size: 13.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: getProportionateScreenHeight(60),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5)),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      widget.data![i]["product_title"],
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    )
                // Positioned(
                //   left: 0,
                //   right: 0,
                //   bottom: _model.bottom,
                //   child: _bottomNavBar,
                // ),

                )));
  }
}
