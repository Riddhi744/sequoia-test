part of 'product_bloc.dart';

@immutable
abstract class ProductEvent extends Equatable {}

class GetProducts extends ProductEvent {
  String sortBy;
  @override
  List<Object?> get props => [sortBy];
  GetProducts({required this.sortBy});
}

// ignore: must_be_immutable
class AddProducts extends ProductEvent {
  Product product;

  @override
  List<Object?> get props => [product];
  AddProducts({required this.product});
}

class DeleteProducts extends ProductEvent {
  String productName;
  @override
  List<Object?> get props => [productName];
  DeleteProducts({required this.productName});
}
