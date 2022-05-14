import 'package:flutter/material.dart';
import 'package:getvalue/services/constants.dart';
import 'package:getvalue/size_confige.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kPrimaryLightColor,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: TextField(
            onChanged: ((value) {
              if (value.isNotEmpty) {
                setState(() {
                  isVisible = true;
                });
              } else {
                setState(() {
                  isVisible = false;
                });
              }
            }),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                    vertical: getRelativeHeight(0.02),
                    horizontal: getRelativeHeight(0.02)),
                fillColor: Colors.white,
                filled: true,
                hintText: "Enter Keyword",
                hintStyle: TextStyle(
                  fontSize: getRelativeWidth(0.046),
                  // color: Colors.blueGrey.withOpacity(0.9),
                ),
                suffixIcon: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getRelativeWidth(0.03)),
                  child: SizedBox(
                    width: getRelativeWidth(0.26),
                    height: getRelativeHeight(0.01),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: getRelativeWidth(0.025)),
                      child: isVisible
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                                Icon(Icons.highlight_remove,
                                    color: Colors.black)
                              ],
                            )
                          : Container(),
                    ),
                  ),
                ),
                border: outlineBorder,
                enabledBorder: outlineBorder,
                focusedBorder: outlineBorder),
          ),
        ),
      ),
    );
  }

  final outlineBorder = OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(10),
  );
}
