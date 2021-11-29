// import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AdaptiveTextFormField extends StatelessWidget {
  String labelText;
  String hintText;
  TextEditingController controller;
  String errorMessage;
  void Function(String?) onSaved;
  AdaptiveTextFormField(
      {required this.hintText,
      required this.controller,
      required this.labelText,
      required this.errorMessage,
      required this.onSaved,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return defaultTargetPlatform == TargetPlatform.iOS
        ? CupertinoTextFormFieldRow(
            prefix: Text(labelText),
            placeholder: hintText,
            controller: controller,
            validator: (value) {
              if (value!.isEmpty) {
                return errorMessage;
              }
              return null;
            },
            onSaved: onSaved,
          )
        : TextFormField(
            controller: controller,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              isDense: true,
              hintText: hintText,
              labelText: labelText,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return errorMessage;
              }
              return null;
            },
            onSaved: onSaved,
          );
  }
}
