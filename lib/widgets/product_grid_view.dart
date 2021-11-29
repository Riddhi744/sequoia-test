import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:sequa_demo/models/product.dart';

// ignore: must_be_immutable
class ProductGridView extends StatelessWidget {
  Product product;
  void Function()? onDeletePressed;
  void Function()? onEditPressed;

  ProductGridView(
      {Key? key,required this.product, required this.onEditPressed, required this.onDeletePressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    Size screenSize = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: SizedBox(
        height: kIsWeb
            ? 180
            : isLandscape
                ? (screenSize.width * 0.25) - 15
                : (MediaQuery.of(context).size.width * 0.5) - 20.0,
        width: kIsWeb
            ? 180
            : isLandscape
                ? (screenSize.width * 0.25) - 15
                : (MediaQuery.of(context).size.width * 0.5) - 20.0,
        child: GridTile(
          child: Container(
            padding: const EdgeInsets.only(left: 8.0),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blue.withOpacity(0.7), Colors.blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomLeft),
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  product.name,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(overflow: TextOverflow.fade),
                ),
                Text(
                    DateFormat.yMMMd().format(
                      product.launchedAt,
                    ),
                    style: Theme.of(context).textTheme.caption),
                RatingBarIndicator(
                  rating: product.popularity,
                  itemBuilder: (context, index) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 30.0,
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black54.withOpacity(0.1),
            leading: IconButton(
              splashRadius: 20,
              onPressed: onDeletePressed,
              icon: Icon(
                defaultTargetPlatform == TargetPlatform.iOS
                    ? CupertinoIcons.delete
                    : Icons.delete_rounded,
                color: Theme.of(context).errorColor,
              ),
            ),
            title: const Text(''),
            trailing: IconButton(
              splashRadius: 20,
              onPressed: onEditPressed,
              icon: const Icon(
                Icons.edit_rounded,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
