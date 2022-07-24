import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import './size_config.dart';

class FormError extends StatelessWidget {
  const FormError({
    Key? key,
    required this.errors,
  }) : super(key: key);

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          errors.length, (index) => formErrorText(error: errors[index])),
    );
  }

  Widget formErrorText({String? error}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: SvgPicture.asset(
              "assets/icons/Error.svg",
              height: getProportionateScreenWidth(14),
              width: getProportionateScreenWidth(14),
            ),
          ),
          Expanded(
              flex: 6,
              child: Text(
                error!,
                style: const TextStyle(color: Colors.red),
              )),
        ],
      ),
    );
  }
}
