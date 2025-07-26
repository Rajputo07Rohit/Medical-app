import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/providers/review_cart_provider.dart';
import 'package:provider/provider.dart';

class CountState extends StatefulWidget {
  String name;
  String img;
  String productId;
  int price;
  CountState(
      {required this.name,
      required this.productId,
      required this.img,
      required this.price,
      super.key});

  @override
  State<CountState> createState() => _CountStateState();
}

class _CountStateState extends State<CountState> {
  int count = 1;
  bool isTrue = false;

  getAddAndQuantity() {
    FirebaseFirestore.instance
        .collection("ProductCartReview")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourReviewCart")
        .doc(widget.productId)
        .get()
        .then((value) => {
              if (this.mounted)
                {
                  if (value.exists)
                    {
                      setState(() {
                        count = value.get("cartQuantity");
                        isTrue = value.get("isAdd");
                      })
                    }
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    getAddAndQuantity();
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    return Container(
        height: 25,
        width: 50,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8)),
        child: isTrue == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      if (count == 1) {
                        setState(() {
                          isTrue = false;
                        });
                        reviewCartProvider
                            .reviewCartDataDelete(widget.productId);
                      } else if (count > 1) {
                        setState(() {
                          count--;
                        });
                        reviewCartProvider.updateReviewCartData(
                          cartId: widget.productId,
                          cartName: widget.name,
                          cartImg: widget.img,
                          cartPrice: widget.price,
                          cartQuantity: count,
                        );
                      }
                    },
                    child: Icon(
                      Icons.remove,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "$count",
                    style: TextStyle(color: Colors.white),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        count++;
                      });
                      reviewCartProvider.updateReviewCartData(
                        cartId: widget.productId,
                        cartName: widget.name,
                        cartImg: widget.img,
                        cartPrice: widget.price,
                        cartQuantity: count,
                      );
                    },
                    child: Icon(
                      Icons.add,
                      size: 12,
                      color: Colors.white,
                    ),
                  )
                ],
              )
            : Center(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isTrue = true;
                    });
                    reviewCartProvider.addReviewCartData(
                      cartId: widget.productId,
                      cartName: widget.name,
                      cartImg: widget.img,
                      cartPrice: widget.price,
                      cartQuantity: count,
                    );
                  },
                  child: Text(
                    "ADD",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ));
  }
}
