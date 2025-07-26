import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:medical_app/models/review_cart_model.dart';

class ReviewCartProvider with ChangeNotifier {
  void addReviewCartData({
    required String cartId,
    required String cartName,
    required String cartImg,
    required int cartPrice,
    required int cartQuantity,
  }) async {
    await FirebaseFirestore.instance
        .collection("ProductCartReview")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourReviewCart")
        .doc(cartId)
        .set({
      "cartId": cartId,
      "cartName": cartName,
      "cartImg": cartImg,
      "cartQuantity": cartQuantity,
      "cartPrice": cartPrice,
      "isAdd": true,
    });
  }

  void updateReviewCartData({
    required String cartId,
    required String cartName,
    required String cartImg,
    required int cartPrice,
    required int cartQuantity,
  }) async {
    await FirebaseFirestore.instance
        .collection("ProductCartReview")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourReviewCart")
        .doc(cartId)
        .update({
      "cartId": cartId,
      "cartName": cartName,
      "cartImg": cartImg,
      "cartQuantity": cartQuantity,
      "cartPrice": cartPrice,
      "isAdd": true,
    });
  }

  List<ReviewCartModel> reviewCartDataList = [];
  void getReviewCartData() async {
    List<ReviewCartModel> newList = [];
    QuerySnapshot reviewCartValue = await FirebaseFirestore.instance
        .collection("ProductCartReview")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourReviewCart")
        .get();
    reviewCartValue.docs.forEach((element) {
      ReviewCartModel reviewCartModel = ReviewCartModel(
        cartId: element.get("cartId"),
        cartImg: element.get("cartImg"),
        cartName: element.get("cartName"),
        cartPrice: element.get("cartPrice"),
        cartQuantity: element.get("cartQuantity"),
      );
      newList.add(reviewCartModel);
    });
    reviewCartDataList = newList;
    notifyListeners();
  }

  List<ReviewCartModel> get getReviewCartDataList {
    return reviewCartDataList;
  }

  //// TotalPrice  ///

  getTotalPrice() {
    double total = 0.0;
    reviewCartDataList.forEach((element) {
      total += element.cartPrice * element.cartQuantity;
    });
    return total;
  }

  ///////////////////ReviewCart Delete///////////////////////
  reviewCartDataDelete(String cartId) {
    FirebaseFirestore.instance
        .collection("ProductCartReview")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourReviewCart")
        .doc(cartId)
        .delete();
    notifyListeners();
  }

  ///////////////////ReviewCart Delete ALL///////////////////////
  // reviewCartDataDeleteAll() {
  //   FirebaseFirestore.instance
  //       .collection("ProductCartReview")
  //       .doc(FirebaseAuth.instance.currentUser?.uid)
  //       .collection("YourReviewCart")
  //       .delete();
  //   notifyListeners();
  // }
  void deleteAllProduct() async {
    var collection = FirebaseFirestore.instance
        .collection("ProductCartReview")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourReviewCart");
    var snapshots = await collection.get();
    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }
}
