import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sequa_demo/models/product.dart';
import 'package:sequa_demo/repositories/firebase.dart';
import 'dart:developer' as developer;
part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  List<Product> products = [];

  final FirebaseQuery _firebaseQuery = FirebaseQuery();
  ProductBloc() : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      if (event is GetProducts) {
        String sortBy = event.sortBy;
        await _firebaseQuery.getProduct(orderBy: event.sortBy).then((event) {
          products.clear();
          event.docs.forEach((element) {
            products.add(Product.fromMap(element));
          });
          print(products);
          emit(ProductsFetched(products: products,sortBy: sortBy));
        }).onError((error, stackTrace) {
          developer.log('error on fetching $error; $stackTrace');
        });
      } else if (event is AddProducts) {
        await _firebaseQuery
            .addProduct(data: event.product.toMap())
            .then((value) {
          developer.log('data saved $value');
          emit(ProductsAdd(success: true));
          add(GetProducts(sortBy: 'name'));
        }).onError((error, stackTrace) {
          emit(ProductsAdd(success: false));
          developer.log('product fetch error $error:$stackTrace');
        });
      } else if (event is DeleteProducts) {
        await _firebaseQuery
            .deleteProduct(name: event.productName)
            .then((value) {
          developer.log('product deleted $value');
          add(GetProducts(sortBy: 'name'));
          emit(ProductsDelete(success: true));
        }).onError((error, stackTrace) {
          emit(ProductsDelete(success: false));
          developer.log('product delete error $error, $stackTrace');
        });
      }
    });
  }
}
