import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseQuery {
  final FirebaseFirestore _fireBase = FirebaseFirestore.instance;

  Future addProduct({required Map<String, dynamic> data}) async {
    await _fireBase.collection('Products').doc(data['name']).set(data);
  }

  Future getProduct(
      {required String orderBy}) async {
    return await _fireBase.collection('Products').orderBy(orderBy).get();
  }

  Future deleteProduct({required String name}) async {
    await _fireBase.collection('Products').doc(name).delete();
  }
}
