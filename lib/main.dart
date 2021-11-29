import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequa_demo/bloc/bloc/product_bloc.dart';
import 'package:sequa_demo/bloc/bloc_observer.dart';
import 'package:sequa_demo/screens/dashboard_screen.dart';
import 'package:sequa_demo/screens/product_adding_screen.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: kDebugMode,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const DashboardScreen(),
        routes: {
          ProductAddingScreen.routeName: (ctx) => const ProductAddingScreen()
        },
      ),
    );
  }
}
