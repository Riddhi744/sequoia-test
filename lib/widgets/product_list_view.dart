import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:sequa_demo/models/product.dart';

// ignore: must_be_immutable
class ProductListView extends StatelessWidget {
  Product product;
  void Function()? onDeletePressed;
  void Function()? onEditPressed;

  ProductListView(
      {Key? key, required this.onEditPressed, required this.product, required this.onDeletePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        onTap: () {
          //TODOlaunch site
        },
        title:  Text(product.name),
        subtitle: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            RatingBarIndicator(
              rating: product.popularity,
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              itemCount: 5,
              itemSize: 20.0,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              DateFormat.yMMMd().format(
                product.launchedAt,
              ),
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              splashRadius: 20,
              onPressed: onDeletePressed,
              icon: Icon(
                defaultTargetPlatform == TargetPlatform.iOS
                    ? CupertinoIcons.delete
                    : Icons.delete_outline_rounded,
                color: Theme.of(context).errorColor,
              ),
            ),
            IconButton(
              splashRadius: 20,
              onPressed: onEditPressed,
              icon: const Icon(Icons.edit_rounded),
            )
          ],
        ),
      ),
    );
  }
}
