import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:medical_app/Screen/review_cart/Cart.dart';
import 'package:medical_app/constants.dart';
import 'package:medical_app/models/Product.dart';
import 'package:medical_app/providers/wishlist_provider.dart';
import 'package:medical_app/widgets/Count.dart';
import 'package:provider/provider.dart';

class ProductOverview extends StatefulWidget {
  const ProductOverview({
    Key? key,
    required this.img,
    required this.name,
    required this.description,
    required this.price,
    required this.productId,
  }) : super(key: key);

  // final Product product;
  final img;
  final name;
  final description;
  final price;
  final productId;

  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  Widget bonntonNavigatorBar({
    required Color iconColor,
    required Color backgroundColor,
    required Color color,
    required String title,
    required IconData iconData,
    required Function() onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(20),
          color: backgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 20,
                color: iconColor,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                title,
                style: TextStyle(color: color, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool wishListBool = false;
  getWishListBool() {
    FirebaseFirestore.instance
        .collection("MyWishList")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("YourWishList")
        .doc(widget.productId)
        .get()
        .then((value) => {
              if (value.exists)
                {
                  setState(
                    () {
                      wishListBool = value.get("wishList");
                    },
                  ),
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    WishListProvider wishListProvider = Provider.of(context);
    getWishListBool();
    return Scaffold(
      bottomNavigationBar: Row(
        children: [
          bonntonNavigatorBar(
              backgroundColor: Colors.black,
              color: Colors.white,
              iconColor: Colors.red,
              title: "Add to Wishlist",
              iconData: wishListBool == false
                  ? Icons.favorite_outline
                  : Icons.favorite,
              onTap: () {
                setState(() {
                  wishListBool = !wishListBool;
                });
                if (wishListBool == true) {
                  wishListProvider.addWishListData(
                    wishListId: widget.productId,
                    wishListImage: widget.img,
                    wishListName: widget.name,
                    wishListPrice: widget.price,
                    wishListQuantity: 2,
                    description: widget.description,
                  );
                } else {
                  wishListProvider.deleteWishtList(widget.productId);
                }
              }),
          bonntonNavigatorBar(
            backgroundColor: kTextSecondary,
            color: Colors.black,
            iconColor: Colors.black,
            title: "Go to Cart",
            iconData: Icons.shopping_cart_rounded,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ReviewCart(),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: kPrimary,
      appBar: AppBar(
        backgroundColor: kPrimary,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Feather.chevron_left,
            color: kTextPrimary,
            size: 30,
          ),
        ),
        title: Text(
          'Product Overview',
          style: TextStyle(
            color: kTextPrimary,
            fontSize: 25,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      widget.name,
                      style: TextStyle(
                        color: kTextPrimary,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '\u20B9 ' + widget.price.toString(),
                      style: TextStyle(
                        color: kTextPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    height: 250,
                    padding: EdgeInsets.all(40),
                    child: Image.network(
                      widget.img,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    child: Text(
                      "Available Options",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: kTextPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 3,
                              backgroundColor: Colors.white,
                            ),
                          ],
                        ),
                        Text(
                          '\u20B9 ' + widget.price.toString(),
                          style: TextStyle(
                            color: kTextPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CountState(
                          img: widget.img,
                          name: widget.name,
                          productId: widget.productId,
                          price: widget.price,
                        ),
                        // Container(
                        //   padding: EdgeInsets.symmetric(
                        //     horizontal: 30,
                        //     vertical: 10,
                        //   ),
                        //   decoration: BoxDecoration(
                        //     border: Border.all(color: Colors.black),
                        //     color: Color(0xFFE55812),
                        //     borderRadius: BorderRadius.circular(
                        //       30,
                        //     ),
                        //   ),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Icon(
                        //         Icons.remove,
                        //         size: 16,
                        //         color: Colors.white,
                        //       ),
                        //       Text(
                        //         "1",
                        //         style: TextStyle(
                        //           color: kTextPrimary,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //       Icon(
                        //         Icons.add,
                        //         size: 16,
                        //         color: Colors.white,
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "About This Product",
                        style: TextStyle(
                          color: kTextPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.description,
                        style: TextStyle(
                          color: kTextPrimary,
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
