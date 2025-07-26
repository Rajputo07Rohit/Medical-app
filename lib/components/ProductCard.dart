import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:medical_app/constants.dart';
import 'package:medical_app/widgets/Count.dart';
// import '../../../Other/constants.dart';
// import 'package:medical_app/models/Product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.img,
    required this.name,
    required this.description,
    required this.price,
    required this.onPressed,
    required this.productId,
  }) : super(key: key);

  final String img;
  final String name;
  final String description;
  final int price;
  final String productId;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
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
              // margin:EdgeInsets.only(left: 10),
              flex: 1,
              child: Image.network(img),
            ),
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: kTextPrimary,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      color: kTextPrimary,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '\u20B9 ' + price.toString(),
                        style: TextStyle(
                          color: kTextPrimary,
                          fontSize: 25,
                        ),
                      ),
                      // Icon(
                      //   Feather.shopping_cart,
                      //   color: kTextPrimary,
                      // ),
                      CountState(
                        productId: productId,
                        img: img,
                        price: price,
                        name: name,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
