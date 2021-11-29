part of 'product_bloc.dart';

@immutable
abstract class ProductState extends Equatable {}

class ProductInitial extends ProductState {
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
class ProductsFetched extends ProductState {
  List<Product> products;
  String sortBy;
  @override
  List<Object?> get props => [products,sortBy];
  ProductsFetched({required this.products,required this.sortBy});
}

class ProductsAdd extends ProductState {
  bool success;
  @override
  List<Object?> get props => [success];
  ProductsAdd({required this.success});
}

class ProductsDelete extends ProductState {
  bool success;
  @override
  List<Object?> get props => [success];
  ProductsDelete({required this.success});
}
