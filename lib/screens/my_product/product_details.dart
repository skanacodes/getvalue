import 'package:dio/dio.dart';
import 'package:extended_sliver/extended_sliver.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:getvalue/screens/my_product/pdfPreviwer.dart';
import 'package:getvalue/services/constants.dart';
import 'package:getvalue/services/size_config.dart';
import 'package:html/parser.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ProductDetails extends StatefulWidget {
  static String routeName = "/productDetails";
  final List? product;
  const ProductDetails({Key? key, this.product}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  String? descr;
  String? initializing;
  double progess = 0;
  bool isDownloading = false;
  bool isDownloadingDone = false;
  List<String> links = [];
  var _openResult = 'Unknown';

  // Future<void> openFile(String? filePath) async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles();

  //   if (result != null) {
  //     filePath = result.files.single.path;
  //   } else {
  //     // User canceled the picker
  //   }
  //   final _result = await OpenFile.open(filePath);
  //   print(_result.message);

  //   setState(() {
  //     _openResult = "type=${_result.type}  message=${_result.message}";
  //   });
  // }

  parseDoc() {
    final document = parse(widget.product![0]["product_synopsis"]);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;
    final lis = widget.product![0]["product_link"].toString().split(";");
    setState(() {
      descr = parsedString.toString();
      links = lis;
    });
  }

  downloadFile(filename, fileappendName) async {
    setState(() {
      isDownloading = true;
    });
    // print(filename);
    //print();
    var pathss = filename.replaceAll(' ', '');
    var dio = Dio();
    var dir = await getExternalStorageDirectory();

    await dio.download(
      pathss,
      "/${dir!.path}/$fileappendName.pdf",
      onReceiveProgress: (rec, total) {
        setState(() {
          print("downloading");
          progess = ((rec / total));
          initializing = (progess * 100).toInt().toString();
          print(progess);
        });
      },
    );
    Future.delayed(const Duration(milliseconds: 1000), () {
// Here you can write your code

      if (initializing == "100") {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => PdfPreviwer(
        //               docPath: "${dir.path}/$fileappendName.pdf".substring(1),
        //             )));
      }
    });
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    parseDoc();
  }

  @override
  Widget build(BuildContext context) {
    print(links);
    return Scaffold(
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: <Widget>[
            ExtendedSliverAppbar(
                // title: const Text(
                //   'ExtendedSliverAppbar',
                //   style: TextStyle(color: Colors.white),
                // ),
                leading: BackButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.white,
                ),
                background: Stack(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: getProportionateScreenHeight(400),
                        child: Image.network(
                          widget.product![0]["product_cover"],
                          fit: BoxFit.fitWidth,
                        )),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: getProportionateScreenHeight(400),
                      decoration: BoxDecoration(
                        color: Colors.cyan[400]!.withOpacity(0.5),
                      ),
                    )
                  ],
                ),
                actions: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.share_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product![index]["product_title"],
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 13.sp),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        const Text(
                          "Description",
                          style: TextStyle(
                            color: Colors.black38,
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        Text(
                          descr.toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            height: 1.6,
                            //letterSpacing: 1.0,
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(50),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: LinearPercentIndicator(
                                // width: 140.0,
                                lineHeight: 5.0,
                                percent: progess,
                                backgroundColor: Colors.grey,
                                progressColor: kPrimaryColor,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Icon(
                                Icons.close,
                                size: 13.sp,
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(50),
                        ),
                        Container(
                          height: getProportionateScreenHeight(10),
                          decoration: BoxDecoration(
                            color: Colors.grey[400]!,
                          ),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        Text(
                          "Author & Status",
                          style:
                              TextStyle(color: Colors.black38, fontSize: 12.sp),
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(20),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                  width: getProportionateScreenHeight(120),
                                  height: getProportionateScreenHeight(120),
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 1, color: Colors.blue),
                                      image: DecorationImage(
                                          fit: BoxFit.contain,
                                          image: NetworkImage(
                                            widget.product![0]["owner_profile"],
                                          )))),
                            ),
                            SizedBox(
                              width: getProportionateScreenHeight(20),
                            ),
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.product![index]["product_owner"]
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12.sp),
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(10),
                                  ),
                                  Text(
                                    widget.product![index]["product_owner"]
                                        .toString(),
                                    style: const TextStyle(
                                      color: Colors.black38,
                                    ),
                                  ),
                                  SizedBox(
                                    height: getProportionateScreenHeight(10),
                                  ),
                                  initializing == null
                                      ? Text(
                                          "Remotely Available",
                                          style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 12.sp),
                                        )
                                      : Text(
                                          initializing.toString() + "%",
                                          style: TextStyle(
                                              color: Colors.black38,
                                              fontSize: 12.sp),
                                        ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(10),
                        ),
                        Container(
                          height: getProportionateScreenHeight(10),
                          decoration: BoxDecoration(
                            color: Colors.grey[400]!,
                          ),
                        ),
                        ListView.builder(
                            itemCount: links.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                child: ListTile(
                                    onTap: () async {
                                      await downloadFile(
                                          links[index].toString(),
                                          widget.product![index]
                                                      ["product_title"]
                                                  .toString() +
                                              index.toString());
                                    },
                                    leading:
                                        const Icon(Icons.menu_book_outlined),
                                    trailing: index == 0
                                        ? const Icon(Icons.download)
                                        : const Icon(
                                            Icons.cloud_download_outlined),
                                    title: index == 0
                                        ? const Text("All Episode")
                                        : Text("Episode $index")),
                              );
                            }),
                      ],
                    ),
                  );
                },
                childCount: widget.product!.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
