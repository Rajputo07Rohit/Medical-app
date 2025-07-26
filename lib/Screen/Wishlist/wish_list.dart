import 'dart:io';

import 'package:flutter/material.dart';
import 'package:medical_app/models/Product.dart';
import 'package:medical_app/providers/wishlist_provider.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../providers/review_cart_provider.dart';
import '../../widgets/single_item.dart';

class WishList extends StatefulWidget {
  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  late WishListProvider wishListProvider;

  showAlertDialog(BuildContext context, Product delete) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        wishListProvider.deleteWishtList(delete.productId);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Wishlist Product"),
      content: Text("Delete WishList Product?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    wishListProvider = Provider.of(context);
    wishListProvider.getWishtListData();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 9, 48, 50),
        elevation: 0,
        title: Text(
          "WishList",
          style: TextStyle(
            color: Color(0xFFEFE7DA),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: wishListProvider.getWishList.length,
        itemBuilder: (context, index) {
          Product data = wishListProvider.getWishList[index];
          return Column(
            children: [
              SizedBox(
                height: 10,
              ),
              SingleItem(
                isBool: false,
                img: data.img,
                price: data.price,
                name: data.name,
                productId: data.productId,
                quantity: data.quantity,
                description: data.description,
                onDelete: () {
                  showAlertDialog(context, data);
                },
              ),
              SizedBox(
                height: 10,
              ),
            ],
          );
        },
      ),
    );
  }
}
