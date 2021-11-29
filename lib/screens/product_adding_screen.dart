import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sequa_demo/models/product.dart';
import 'package:sequa_demo/widgets/product_form.dart';

class ProductAddingScreen extends StatelessWidget {
  const ProductAddingScreen({Key? key}) : super(key: key);
  static const routeName = '/product-adding-screen';

  @override
  Widget build(BuildContext context) {
    Map<String, Object>? data =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>?;
    if (data == null) {
      Navigator.of(context).popUntil(ModalRoute.withName('/'));
      return const Text('');
    }

    return defaultTargetPlatform == TargetPlatform.iOS
        // building IOS scaffold
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text(
                  (data['edit'] as bool) ? 'Edit Product' : 'Add Product'),
            ),
            child: ProductAddingForm(
                product: data.containsKey('product')
                    ? (data['product'] as Product)
                    : null),
          )

        // building Android and web scaffold
        : Scaffold(
            appBar: AppBar(
              title: Text(
                  (data['edit'] as bool) ? 'Edit Product' : 'Add Product'),
            ),
            body: ProductAddingForm(
                product: data.containsKey('product')
                    ? (data['product'] as Product)
                    : null),
          );
  }
}
