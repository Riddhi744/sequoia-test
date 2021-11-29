import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequa_demo/bloc/bloc/product_bloc.dart';
import 'package:sequa_demo/screens/product_adding_screen.dart';
import 'package:sequa_demo/widgets/dashboard_body.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return defaultTargetPlatform == TargetPlatform.iOS
        // building IOS scaffold
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: const Text('DashBoard'),
              trailing: GestureDetector(
                child: const Icon(CupertinoIcons.add),
                onTap: () {
                  Navigator.of(context).pushNamed(ProductAddingScreen.routeName,
                       arguments: {'edit':false});
                },
              ),
            ),
            child: const DashboardBody(),
          )

        // building Android and web scaffold
        : Scaffold(
            appBar: AppBar(
              title: const Text('DashBoard'),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                        ProductAddingScreen.routeName,
                        arguments: {'edit':false});
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            body: const DashboardBody(),
          );
  }
}
