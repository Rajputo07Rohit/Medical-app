import 'package:flutter/material.dart';
import 'package:medical_app/providers/orderH_provider.dart';
import 'package:provider/provider.dart';

import '../Widgets/single_item.dart';
import '../constants.dart';
import '../models/orderHmodel.dart';
import 'Check_Out/payment_summary/order_his_item.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  late OrderHisProvider orderHisProvider;

  @override
  Widget build(BuildContext context) {
    orderHisProvider = Provider.of<OrderHisProvider>(context);
    orderHisProvider.getorderData();

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Order History",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          backgroundColor: kPrimary,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: orderHisProvider.getOrderDataList.isEmpty
              ? Center(
                  child: Text(
                    "No Order Items",
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ExpansionTile(
                          children: orderHisProvider.getOrderDataList.map((e) {
                            return OrderhisItems(e: e);
                          }).toList(),
                          title: Text(
                            "Orders ID :       ${orderHisProvider.getOrderDataList[index].orderId}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Divider(),
                      ],
                    );
                  },
                ),
        ));
  }
}
