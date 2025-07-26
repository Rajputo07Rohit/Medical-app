import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/models/Product.dart';

class WishListProvider with ChangeNotifier {
  void addWishListData({
    required String wishListId,
    required String wishListName,
    required String wishListImage,
    required int wishListPrice,
    required int wishListQuantity,
    required String description,
  }) async {
    await FirebaseFirestore.instance
        .collection("MyWishList")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourWishList")
        .doc(wishListId)
        .set({
      "wishListId": wishListId,
      "wishListName": wishListName,
      "wishListImage": wishListImage,
      "wishListPrice": wishListPrice,
      "wishListQuantity": wishListQuantity,
      "wishList": true,
      "wishListDescription": description,
    });
  }

  ///// Get WishList Data ///////
  List<Product> wishList = [];

  getWishtListData() async {
    List<Product> newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection("MyWishList")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourWishList")
        .get();
    value.docs.forEach(
      (element) {
        Product productModel = Product(
          productId: element.get("wishListId"),
          img: element.get("wishListImage"),
          name: element.get("wishListName"),
          price: element.get("wishListPrice"),
          quantity: element.get("wishListQuantity"),
          description: element.get("wishListDescription"),
        );
        newList.add(productModel);
      },
    );
    wishList = newList;
    notifyListeners();
  }

  List<Product> get getWishList {
    return wishList;
  }

////////// Delete WishList /////
  deleteWishtList(wishListId) {
    FirebaseFirestore.instance
        .collection("MyWishList")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourWishList")
        .doc(wishListId)
        .delete();
  }
}
