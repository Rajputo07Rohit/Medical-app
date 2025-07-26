// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:flutter/material.dart';
// import 'package:pay/pay.dart';
// class MyGooglePay extends StatefulWidget {
//   const MyGooglePay({super.key});

//   @override
//   State<MyGooglePay> createState() => _MyGooglePayState();
// }

// class _MyGooglePayState extends State<MyGooglePay> {
//   var _paymentItems = [
//     PaymentItem(
//       label: 'Total',
//       amount: '99.99',
//       status: PaymentItemStatus.final_price,
//     )
//   ];

// // In your Widget build() method

// // In your Stateless Widget class or State
//   void onGooglePayResult(paymentResult) {
//     // Send the resulting Google Pay token to your server or PSP
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GooglePayButton(
//   // paymentConfiguration: PaymentConfiguration.fromJsonString(
//   //     defaultGooglePayConfigString),
//   paymentConfiguration: PaymentConfiguration.fromJsonString(
//       defaultGooglePayConfigString),
//   paymentItems: _paymentItems,
//   type: GooglePayButtonType.pay,
//   margin: const EdgeInsets.only(top: 15.0),
//   onPaymentResult: onGooglePayResult,
//   loadingIndicator: const Center(
//     child: CircularProgressIndicator(),
//   ),
//   }
// }
