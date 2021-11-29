import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sequa_demo/bloc/bloc/product_bloc.dart';
import 'package:sequa_demo/models/product.dart';
import 'package:sequa_demo/widgets/adaptive_alert_dailog.dart';
import 'package:sequa_demo/widgets/adaptive_elevated_button.dart';
import 'package:sequa_demo/widgets/adaptive_text_field.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sequa_demo/widgets/adaptive_text_button.dart';

// ignore: must_be_immutable
class ProductAddingForm extends StatefulWidget {
  Product? product;
  ProductAddingForm({Key? key, required this.product}) : super(key: key);

  @override
  _ProductAddingFormState createState() => _ProductAddingFormState();
}

class _ProductAddingFormState extends State<ProductAddingForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  Product product = Product(
      name: '', launchedAt: DateTime.now(), launchSite: '', popularity: 0);

  TextEditingController nameController = TextEditingController();
  TextEditingController linkController = TextEditingController();
  DateTime? _selectedDate;
  double popularity = 0.0;

// date choosen calender adaptive
  void _datepicker() {
    defaultTargetPlatform == TargetPlatform.iOS
        ? CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: DateTime.now(),
            onDateTimeChanged: (pickeddate) {
              setState(() {
                _selectedDate = pickeddate;
              });
            },
          )
        : showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime.now())
            .then((pickeddate) {
            if (pickeddate == null) {
              return;
            }
            setState(() {
              _selectedDate = pickeddate;
            });
          });
  }

  // scaffold message widget
  _scaffoldMessage(String snackBarMessage) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        content: Text(snackBarMessage),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void initState() {
    if (widget.product != null) {
      nameController.text = widget.product!.name;
      linkController.text = widget.product!.launchSite;
      _selectedDate = widget.product!.launchedAt;
      popularity = widget.product!.popularity;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: Container(
          width: kIsWeb ? 650 : null,
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
          child: Column(
            children: [
              // product name field
              Padding(
                padding: kIsWeb
                    ? const EdgeInsets.symmetric(vertical: 16.0)
                    : const EdgeInsets.symmetric(vertical: 8.0),
                child: AdaptiveTextFormField(
                  hintText: 'Product Name',
                  controller: nameController,
                  labelText: 'Product Name',
                  errorMessage: '* Please enter product name',
                  onSaved: (_) {
                    product.name = nameController.text;
                  },
                ),
              ),
              // product name field
              Padding(
                padding: kIsWeb
                    ? const EdgeInsets.symmetric(vertical: 16.0)
                    : const EdgeInsets.symmetric(vertical: 8.0),
                child: AdaptiveTextFormField(
                  hintText: 'Product Link',
                  controller: linkController,
                  labelText: 'Product Link',
                  errorMessage: '* Please enter product link',
                  onSaved: (_) {
                    product.name = linkController.text;
                  },
                ),
              ),
              // date picker
              Padding(
                padding: kIsWeb
                    ? const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 8.0)
                    : const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_selectedDate == null
                        ? 'No Date Choosen!'
                        : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}'),
                    AdaptiveTextButton(
                      text: 'Choose a Date',
                      onPressed: _datepicker,
                    )
                  ],
                ),
              ),
              // rating bar widget
              Padding(
                padding: kIsWeb
                    ? const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 8.0)
                    : const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Choose Rating :'),
                    RatingBar.builder(
                      glowRadius: 0.05,
                      initialRating: popularity,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 30.0,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        popularity = rating;
                      },
                    ),
                  ],
                ),
              ),
              // action buttons
              Padding(
                padding: kIsWeb
                    ? const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 8.0)
                    : const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // discard button
                    AdaptiveTextButton(
                        onPressed: () {
                          defaultTargetPlatform == TargetPlatform.iOS
                              ? showCupertinoDialog<void>(
                                  context: context,
                                  builder: (ctx) => AdaptiveAlertDailog(
                                    subTitle: 'Do you want to discard form?',
                                    onPressedDone: () {
                                      Navigator.of(ctx).pop();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                )
                              : showDialog(
                                  context: context,
                                  builder: (ctx) => AdaptiveAlertDailog(
                                    subTitle: 'Do you want to discard form?',
                                    onPressedDone: () {
                                      Navigator.of(ctx).pop();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                );
                        },
                        text: 'Discard'),
                    const SizedBox(
                      width: 10,
                    ),
                    // save button
                    AdaptiveElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // checking date is selected or not
                            if (_selectedDate != null) {
                              // checking rating is selected or not
                              if (popularity >= 1.0) {
                                _formKey.currentState!.save();
                                defaultTargetPlatform == TargetPlatform.iOS
                                    ? showCupertinoDialog<void>(
                                        context: context,
                                        builder: (ctx) => AdaptiveAlertDailog(
                                          subTitle:
                                              'Do you want to add this product?',
                                          onPressedDone: () {
                                            Navigator.of(ctx).pop();
                                            Navigator.of(context).pop();
                                            // TODOimplement for IOS save button
                                          },
                                        ),
                                      )
                                    : showDialog(
                                        context: context,
                                        builder: (ctx) => AdaptiveAlertDailog(
                                          subTitle:
                                              'Do you want to add this product?',
                                          onPressedDone: () {
                                            Navigator.of(ctx).pop();
                                            Navigator.of(context).pop();
                                            //TODOproduct adding on database and show a message added
                                            BlocProvider.of<ProductBloc>(
                                                    context)
                                                .add(AddProducts(
                                                    product: Product(
                                                        name: nameController
                                                            .text,
                                                        launchedAt:
                                                            _selectedDate!,
                                                        launchSite:
                                                            linkController.text,
                                                        popularity:
                                                            popularity)));
                                          },
                                        ),
                                      );
                              } else {
                                _scaffoldMessage(
                                    'Please select product rating');
                              }
                            } else {
                              _scaffoldMessage('Please choose a launch date');
                            }
                          }
                        },
                        text: 'Save')
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
