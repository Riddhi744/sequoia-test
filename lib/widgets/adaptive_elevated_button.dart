import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class AdaptiveElevatedButton extends StatelessWidget {
  void Function()? onPressed;
  String text;
  FontWeight? fontWeight;
  AdaptiveElevatedButton(
      {Key? key, required this.onPressed, required this.text, this.fontWeight})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return defaultTargetPlatform == TargetPlatform.iOS
        ? CupertinoButton(
            onPressed: onPressed,
            color: Theme.of(context).primaryColor,
            child: Text(
              text,
              style: TextStyle(fontWeight: fontWeight),
            ),
          )
        : ElevatedButton(
            onPressed: onPressed,
            child: Text(
              text,
              style: TextStyle(fontWeight: fontWeight),
            ),
          );
  }
}
