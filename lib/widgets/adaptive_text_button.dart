import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class AdaptiveTextButton extends StatelessWidget {
  void Function()? onPressed;
  String text;
  FontWeight? fontWeight;
  AdaptiveTextButton(
      {Key? key, required this.onPressed, required this.text, this.fontWeight})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return defaultTargetPlatform == TargetPlatform.iOS
        ? CupertinoButton(
            onPressed: onPressed,
            child: Text(
              text,
              style: TextStyle(fontWeight: fontWeight),
            ),
          )
        : TextButton(
            onPressed: onPressed,
            child: Text(
              text,
              style: TextStyle(fontWeight: fontWeight),
            ),
          );
  }
}
