import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medical_app/Screen/Product_view/product_overview.dart';
import 'package:medical_app/Screen/Wishlist/wish_list.dart';
import 'package:medical_app/providers/review_cart_provider.dart';
import 'package:medical_app/widgets/Count.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class SingleItem extends StatefulWidget {
  // bool isBool = false;
  // SingleItem({required this.isBool});
  SingleItem({
    Key? key,
    required this.img,
    required this.name,
    required this.description,
    required this.price,
    required this.isBool,
    required this.productId,
    this.quantity,
    required this.onDelete,
    this.WishList,
  }) : super(key: key);
  final isBool;
  final img;
  final name;
  final description;
  final price;
  final productId;
  final quantity;
  final Function() onDelete;
  final WishList;

  @override
  State<SingleItem> createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  late int count;
  getCount() {
    setState(() {
      count = widget.quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    getCount();
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductOverview(
                description: widget.description,
                img: widget.img,
                name: widget.name,
                price: widget.price,
                productId: widget.productId,
              ))),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        margin: EdgeInsets.only(bottom: 15),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: kTextSecondary,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF073738),
              offset: Offset(2, 3),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Image.network(
                widget.img,
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: widget.isBool == false
                    ? MainAxisAlignment.spaceAround
                    : MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(
                      color: kTextPrimary,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.description,
                    style: TextStyle(
                      color: kTextPrimary,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 15),
                  widget.isBool == false
                      ? Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                // '\u20B9 ' + product.price.toString(),
                                '\u20B9 ' + widget.price.toString(),
                                style: TextStyle(
                                  color: kTextPrimary,
                                  fontSize: 25,
                                ),
                              ),
                              // Icon(
                              //   Feather.shopping_cart,
                              //   color: kTextPrimary,
                              // ),
                            ],
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              // '\u20B9 ' + product.price.toString(),
                              '\u20B9 ' + widget.price.toString(),
                              style: TextStyle(
                                color: kTextPrimary,
                                fontSize: 25,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black87),
                                color: Colors.white12,
                                borderRadius: BorderRadius.circular(
                                  20,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (count == 1) {
                                        Fluttertoast.showToast(
                                            msg: "You reach minimum  limit ");
                                      } else {
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
                                      size: 24,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    " $count ",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: kTextPrimary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (count < 10) {
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
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "You reach maximum limit ");
                                      }
                                    },
                                    child: Icon(
                                      Icons.add,
                                      size: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: widget.onDelete,
                              child: Icon(Icons.delete),
                            ),
                          ],
                        )
                ],
              ),
            ),
            widget.isBool == false
                ? Container()
                : Divider(height: 1, color: Colors.black)
          ],
        ),
      ),
    );
  }
}
