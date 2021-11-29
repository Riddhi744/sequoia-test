import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String name;
  DateTime launchedAt;
  String launchSite;
  double popularity;

  Product(
      {required this.name,
      required this.launchedAt,
      required this.launchSite,
      required this.popularity});

  factory Product.fromMap(map) {
    return Product(
        name: map['name'],
        launchedAt: (map['launchedAt'] as Timestamp).toDate(),
        launchSite: map['launchSite'],
        popularity: map['popularity']);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'launchedAt': Timestamp.fromDate(launchedAt),
      'launchSite': launchSite,
      'popularity': popularity
    };
  }

  @override
  String toString() {
    // TODOimplement toString
    return 'name: $name, launchedAt: $launchedAt, launchSite: $launchSite, popularity: $popularity';
  }
}
