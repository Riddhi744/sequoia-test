import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class AdaptiveAlertDailog extends StatelessWidget {
  String subTitle;
  void Function()? onPressedDone;
  AdaptiveAlertDailog({
    Key? key,
    required this.subTitle,
    this.onPressedDone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return defaultTargetPlatform == TargetPlatform.iOS
        ? CupertinoAlertDialog(
            title: const Text('Are you sure?'),
            content: Text(subTitle),
            actions: <CupertinoDialogAction>[
              CupertinoDialogAction(
                child: const Text('No'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CupertinoDialogAction(
                child: const Text('Yes'),
                onPressed: onPressedDone,
              )
            ],
          )
        : AlertDialog(
            title: const Text('Are you sure?'),
            content: Text(subTitle),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No'),
              ),
              ElevatedButton(
                onPressed: onPressedDone,
                child: const Text('Yes'),
              )
            ],
          );
  }
}
