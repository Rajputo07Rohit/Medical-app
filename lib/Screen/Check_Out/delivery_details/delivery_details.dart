import 'package:flutter/material.dart';
import 'package:medical_app/Screen/Check_Out/delivery_details/Add_Delivery_Details/add_delivery_address.dart';
import 'package:medical_app/Screen/Check_Out/delivery_details/single_delivery_item.dart';
import 'package:medical_app/Screen/Check_Out/payment_summary/payment_summary.dart';
import 'package:medical_app/constants.dart';
import 'package:medical_app/models/delivery_address_model.dart';
import 'package:medical_app/providers/check_out_provider.dart';
import 'package:provider/provider.dart';

class DeliveryDetails extends StatefulWidget {
  DeliveryDetails({super.key});

  @override
  State<DeliveryDetails> createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  // List<Widget> address = [
  bool isAddress = false;

  @override
  Widget build(BuildContext context) {
    late DeliveryAddressModel value;
    CheckoutProvider deliveryAdressProvider = Provider.of(context);
    deliveryAdressProvider.getDeliveryAddressData();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 16, 160, 209),
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddDeliverAddress(),
            ),
          );
        },
      ),
      appBar: AppBar(
        title: const Text("Delivery Details"),
        backgroundColor: const Color.fromARGB(255, 3, 75, 95),
      ),
      bottomNavigationBar: Container(
        width: 160,
        height: 50,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: MaterialButton(
          color: const Color.fromARGB(255, 47, 112, 130),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: deliveryAdressProvider.getDeliveryAddressList.isEmpty
              ? const Text(
                  "Add new Address",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )
              : const Text(
                  "Payment Summary",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
          onPressed: () {
            deliveryAdressProvider.getDeliveryAddressList.isEmpty
                ? Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddDeliverAddress(),
                    ),
                  )
                : Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PaymentSummary(
                        deliveryAddressList: value,
                      ),
                    ),
                  );
          },
        ),
      ),
      body: ListView(
        children: [
          const ListTile(
            title: Text("Deliver To"),
            // leading: Image.network("https://www.google.com/search?q=location+sign&sxsrf=APwXEdcznrrt9SIUC1ktjEREP_ND0AZtEg:1681383637206&source=lnms&tbm=isch&sa=X&ved=2ahUKEwjT27ST2qb-AhWqxTgGHdN9D2wQ_AUoAXoECAEQAw&biw=1504&bih=852&dpr=1.5#imgrc=zi2SBP6XW8L4fM",

            // height: 30,
            // ),
          ),
          const Divider(
            height: 1,
          ),
          deliveryAdressProvider.getDeliveryAddressList.isEmpty
              ? Container(
                  child: Center(
                    child: Text("No Data"),
                  ),
                )
              : Column(
                  children:
                      deliveryAdressProvider.getDeliveryAddressList.map((e) {
                  setState(() {
                    value = e;
                  });
                  return SingleDeliveryItem(
                    address: ",street, ${e.street} , society ${e.society},  ",
                    title: " ${e.firstName} ${e.lastName} ",
                    addressType: e.addressType == "AddressTypes.Other"
                        ? "Other"
                        : e.addressType == "AddressTypes.Home"
                            ? "Home"
                            : "Work",
                    number: "${e.mobileNo}",
                  );
                }).toList()),
        ],
      ),
    );
  }
}
