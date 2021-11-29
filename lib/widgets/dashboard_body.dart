import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequa_demo/bloc/bloc/product_bloc.dart';
import 'package:sequa_demo/models/product.dart';
import 'package:sequa_demo/screens/product_adding_screen.dart';
import 'package:sequa_demo/widgets/adaptive_alert_dailog.dart';
import 'package:sequa_demo/widgets/product_grid_view.dart';
import 'package:sequa_demo/widgets/product_list_view.dart';

class DashboardBody extends StatefulWidget {
  const DashboardBody({Key? key}) : super(key: key);

  @override
  _DashboardBodyState createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  bool isGridVew = false;
  String sortBy = 'launchedAt';
  List<String> sortList = ['launchedAt', 'name', 'popularity'];

  @override
  void initState() {
    BlocProvider.of<ProductBloc>(context).add(GetProducts(sortBy: sortBy));
    super.initState();
  }

  void _deleteProduct(Product product) {
    defaultTargetPlatform == TargetPlatform.iOS
        ? showCupertinoDialog<void>(
            context: context,
            builder: (ctx) => AdaptiveAlertDailog(
              subTitle: 'Do you want to delete this product?',
              onPressedDone: () {
                BlocProvider.of<ProductBloc>(context)
                    .add(DeleteProducts(productName: product.name));
                Navigator.of(context).pop();
              },
            ),
          )
        : showDialog(
            context: context,
            builder: (ctx) => AdaptiveAlertDailog(
              subTitle: 'Do you want to delete this product?',
              onPressedDone: () {
                BlocProvider.of<ProductBloc>(context)
                    .add(DeleteProducts(productName: product.name));
                Navigator.of(context).pop();
              },
            ),
          );
  }

  void _editProduct(Product product) {
    Navigator.of(context).pushNamed(ProductAddingScreen.routeName,
        arguments: {'product': product, 'edit': true});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: IconButton(
                  splashRadius: 20,
                  onPressed: () {
                    setState(() {
                      isGridVew = !isGridVew;
                    });
                  },
                  icon: defaultTargetPlatform == TargetPlatform.iOS
                      ? Icon(isGridVew
                          ? CupertinoIcons.square_grid_2x2_fill
                          : CupertinoIcons.list_bullet)
                      : Icon(isGridVew
                          ? Icons.grid_view_rounded
                          : Icons.list_rounded),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              // dropdown
              const Text('Sort By '),
              DropdownButton(
                borderRadius: BorderRadius.circular(10),
                iconSize: 18.0,
                underline: const SizedBox(),
                elevation: 4,
                value: sortBy,
                style: Theme.of(context).textTheme.bodyText1,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: sortList.map(
                  (String items) {
                    return DropdownMenuItem(value: items, child: Text(items));
                  },
                ).toList(),
                onChanged: (newValue) {
                  setState(() {
                    sortBy = newValue as String;
                  });
                  BlocProvider.of<ProductBloc>(context)
                      .add(GetProducts(sortBy: sortBy));
                },
              ),
            ],
          ),
          isGridVew
              ? Expanded(
                  child: BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                      if (state is ProductsFetched) {
                        return SingleChildScrollView(
                          child: Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: List.generate(
                              state.products.length,
                              (index) {
                                return ProductGridView(
                                  product: state.products[index],
                                  onDeletePressed: () {
                                    _deleteProduct(state.products[index]);
                                  },
                                  onEditPressed: () {
                                    _editProduct(state.products[index]);
                                  },
                                );
                              },
                            ),
                          ),
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                )
              :
              // Product List
              Expanded(
                  child: BlocConsumer<ProductBloc, ProductState>(
                    listener: (context, state) {
                      if (state is ProductsAdd) {
                        if (state.success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Product added successfully')));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('unable to add Product ')));
                        }
                      } else if (state is ProductsDelete) {
                        if (state.success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Product deleted successfully')));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('unable to delete Product ')));
                        }
                      }
                      // BlocProvider.of<ProductBloc>(context)
                      //     .add(GetProducts(sortBy: sortBy));
                    },
                    builder: (BuildContext context, Object? state) {
                      if (state is ProductsFetched) {
                        return ListView.builder(
                          itemBuilder: (ctx, index) {
                            return ProductListView(
                              product: state.products[index],
                              onDeletePressed: () {
                                _deleteProduct(state.products[index]);
                              },
                              onEditPressed: () {
                                _editProduct(state.products[index]);
                              },
                            );
                          },
                          itemCount: state.products.length,
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
