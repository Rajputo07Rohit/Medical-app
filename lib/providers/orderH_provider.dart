import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/models/Product.dart';

import '../models/orderHmodel.dart';
import '../models/review_cart_model.dart';

class OrderHisProvider with ChangeNotifier {
  void addorderData({
    required String orderId,
    required String orderName,
    required String orderImg,
    required int orderPrice,
    required int orderQuantity,
  }) async {
    await FirebaseFirestore.instance
        .collection("MyOrderH")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourOrderH")
        .doc(orderId)
        .set({
      "orderId": orderId,
      "orderName": orderName,
      "orderImg": orderImg,
      "orderPrice": orderPrice,
      "orderQuantity": orderQuantity,
      "order": true
    });
  }

  List<OrderHisModel> OrderH = [];

  getorderData() async {
    List<OrderHisModel> newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection("MyOrderH")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourOrderH")
        .get();
    value.docs.forEach(
      (element) {
        OrderHisModel orderHisModels = OrderHisModel(
          orderId: element.get("orderId"),
          orderImg: element.get("orderImg"),
          orderName: element.get("orderName"),
          orderPrice: element.get("orderPrice"),
          orderQuantity: element.get("orderQuantity"),
        );
        newList.add(orderHisModels);
      },
    );
    OrderH = newList;
    notifyListeners();
  }

  List<OrderHisModel> get getOrderDataList {
    return OrderH;
  }
}
