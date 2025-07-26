import 'package:flutter/material.dart';
import 'package:medical_app/models/review_cart_model.dart';

class OrderItems extends StatelessWidget {
  OrderItems({required this.e, super.key});
  // bool isTrue;
  final ReviewCartModel e;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        e.cartImg,
        width: 60,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            e.cartName,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          Text(
            "\₹${e.cartPrice}",
          )
        ],
      ),
      subtitle: Text(e.cartQuantity.toString()),
    );
  }
}
