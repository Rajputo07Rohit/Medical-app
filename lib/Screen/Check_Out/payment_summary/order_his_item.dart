import 'package:flutter/material.dart';
import 'package:medical_app/models/orderHmodel.dart';
import 'package:medical_app/models/review_cart_model.dart';

class OrderhisItems extends StatelessWidget {
  OrderhisItems({required this.e, super.key});
  // bool isTrue;
  final OrderHisModel e;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        e.orderImg,
        width: 60,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            e.orderName,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          Text(
            "\₹${e.orderPrice}",
          )
        ],
      ),
      subtitle: Text(e.orderQuantity.toString()),
    );
  }
}
