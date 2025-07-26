import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:medical_app/Screen/Check_Out/delivery_details/single_delivery_item.dart';
import 'package:medical_app/main.dart';
import 'package:medical_app/models/Product.dart';
import 'package:medical_app/models/delivery_address_model.dart';
// import 'package:medical_app/models/delivery_model.dart';
import 'package:medical_app/providers/check_out_provider.dart';
import 'package:medical_app/providers/orderH_provider.dart';
import 'package:medical_app/providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../constants.dart';
import '../../../providers/review_cart_provider.dart';
// import '../single_delivery_item.dart';
import 'package:quickalert/quickalert.dart';
import 'order_item.dart';

class PaymentSummary extends StatefulWidget {
  PaymentSummary({super.key, required this.deliveryAddressList});

  final DeliveryAddressModel deliveryAddressList;

  @override
  State<PaymentSummary> createState() => _PaymentSuState();
}

enum AddressTypes {
  UPI,
  Cash_On_delivery,
  // Other,
}

class _PaymentSuState extends State<PaymentSummary> {
  late ReviewCartProvider reviewCartProvider;
  void showAlert() {
    QuickAlert.show(
      context: context,
      title: 'Order Placed!',
      type: QuickAlertType.success,
      text: 'Thank you for shopping wih us.',
      onConfirmBtnTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => HomePage()));
      },
    );
  }

  void showAlertError() {
    QuickAlert.show(
      context: context,
      title: 'Failed!',
      type: QuickAlertType.error,
      text: 'Transaction Failed.',
      onConfirmBtnTap: () {
        // Navigator.of(context)
        // .push(MaterialPageRoute(builder: (context) => PaymentSummary(deliveryAddressList: deliveryAddressList)));
      },
    );
  }

  Razorpay? _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay?.clear();
  }

  void openPaymentPortal() async {
    var options = {
      'key': 'rzp_test_VOm9lI5NnvNAJE',
      // 'amount': "\₹69",
      // 'name': 'jhon',
      'description': 'Payment',
      'prefill': {'contact': '9999999999', 'email': 'jhon@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay?.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS PAYMENT: ${response.paymentId}", timeInSecForIosWeb: 4);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR HERE: ${response.code} - ${response.message}",
        timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET IS : ${response.walletName}",
        timeInSecForIosWeb: 4);
  }

  var myType = AddressTypes.UPI;
  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();
    OrderHisProvider orderHisProvider = Provider.of(context);
    double discount = 30;
    double discountValue = 0;
    double shippingCharge = 20;
    double total = 0;
    double totalPrice = reviewCartProvider.getTotalPrice();

    if (totalPrice > 300) {
      discountValue = (totalPrice * discount) / 100;
      total = totalPrice - discountValue;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Payment Summary",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: kPrimary,
      ),
      bottomNavigationBar: ListTile(
        title: const Text(
          "Total Amount",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: totalPrice > 300
            ? Text(
                // " \₹ ${total + 30}",
                "\₹${total + 30 ?? totalPrice}",
                style: TextStyle(
                  color: Color.fromARGB(255, 28, 157, 11),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              )
            : Text(
                " \₹ ${totalPrice + 30}",
                style: TextStyle(
                  color: Color.fromARGB(255, 28, 157, 11),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
        trailing: SizedBox(
          width: 140,
          child: MaterialButton(
            color: Color(0xFFE55812),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            onPressed: () {
              if (AddressTypes.UPI != myType) {
                // print("O");
                // openPaymentPortal();
                // print("Oye");
                reviewCartProvider.getReviewCartDataList.map((e) {
                  orderHisProvider.addorderData(
                      orderId: e.cartId,
                      orderName: e.cartName,
                      orderImg: e.cartImg,
                      orderPrice: e.cartPrice,
                      orderQuantity: e.cartQuantity);
                }).toList();
                showAlert();
              } else {
                openPaymentPortal();
                // showAlertError();
              }
              reviewCartProvider.deleteAllProduct();
            },
            child: const Text(
              "Place order",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Column(
              children: [
                SingleDeliveryItem(
                  address:
                      "street, ${widget.deliveryAddressList.street} , society ${widget.deliveryAddressList.society}",
                  title:
                      " ${widget.deliveryAddressList.firstName} ${widget.deliveryAddressList.lastName} ",
                  addressType: widget.deliveryAddressList.addressType ==
                          "AddressTypes.Other"
                      ? "Other"
                      : widget.deliveryAddressList.addressType ==
                              "AddressTypes.Home"
                          ? "Home"
                          : "Work",
                  number: "${widget.deliveryAddressList.mobileNo}",
                ),
                Divider(),
                ExpansionTile(
                  children: reviewCartProvider.getReviewCartDataList.map((e) {
                    return OrderItems(e: e);
                  }).toList(),
                  title: Text(
                    "Order Item ${reviewCartProvider.getReviewCartDataList.length} ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(),
                ListTile(
                  minVerticalPadding: 5,
                  leading: Text(
                    "Sub Total",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    "\₹${totalPrice}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  minVerticalPadding: 5,
                  leading: Text(
                    "Shipping Charge",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  trailing: Text(
                    "\₹30",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                  minVerticalPadding: 5,
                  leading: Text(
                    "Discount",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  trailing: Text(
                    " -  \₹${discountValue}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(),
                ListTile(
                  minVerticalPadding: 5,
                  leading: Text(
                    "Payment Option ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                RadioListTile(
                  value: AddressTypes.UPI,
                  groupValue: myType,
                  title: const Text("RazorPay"),
                  onChanged: (AddressTypes? value) {
                    setState(() {
                      myType = value!;
                    });
                  },
                  secondary: const Icon(
                    Icons.payment,
                    color: Colors.blueAccent,
                  ),
                ),
                RadioListTile(
                  value: AddressTypes.Cash_On_delivery,
                  groupValue: myType,
                  title: const Text("Cash On Delivey"),
                  onChanged: (AddressTypes? value) {
                    setState(() {
                      myType = value!;
                    });
                  },
                  secondary: const Icon(
                    Icons.home,
                    color: Colors.blueAccent,
                  ),
                ),
                // RadioListTile(
                //   value: AddressTypes.Other,
                //   groupValue: myType,
                //   title: const Text("Other"),
                //   onChanged: (AddressTypes? value) {
                //     setState(() {
                //       myType = value!;
                //     });
                //   },
                // secondary: const Icon(
                //   Icons.devices_other,
                //   color: Colors.blueAccent,
                // ),
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}
