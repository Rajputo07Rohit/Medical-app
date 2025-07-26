import 'package:flutter/material.dart';
import 'package:medical_app/Screen/Check_Out/delivery_details/delivery_details.dart';
import 'package:medical_app/Widgets/single_item.dart';
import 'package:medical_app/constants.dart';
import 'package:medical_app/models/review_cart_model.dart';
import 'package:medical_app/providers/review_cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

//ignore: must_be_immutable
class ReviewCart extends StatelessWidget {
  ReviewCart({super.key});
  late ReviewCartProvider reviewCartProvider;
  showAlertDialog(BuildContext context, ReviewCartModel delete) {
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
        reviewCartProvider.reviewCartDataDelete(delete.cartId);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Cart Product"),
      content: Text("Want to remove this product?"),
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
    reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();

    return Scaffold(
      bottomNavigationBar: ListTile(
        title: Text("Total Amount"),
        subtitle: Text("Rs. ${reviewCartProvider.getTotalPrice()}"),
        trailing: Container(
          width: 160,
          child: MaterialButton(
            child: Text(
              "Submit",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              if (reviewCartProvider.getReviewCartDataList.isEmpty) {
                Fluttertoast.showToast(msg: "This is a Toast message");
                // Text("Oops no data");
                // return null;
              } else {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => DeliveryDetails()));
              }
            },
          ),
          color: kPrimary,
        ),
      ),
      appBar: AppBar(
        title: Text("Review Cart"),
        backgroundColor: kPrimary,
      ),
      body: reviewCartProvider.getReviewCartDataList.isEmpty
          ? Center(
              child: Text("NO DATA"),
            )
          : ListView.builder(
              itemCount: reviewCartProvider.getReviewCartDataList.length,
              itemBuilder: (context, index) {
                ReviewCartModel data =
                    reviewCartProvider.getReviewCartDataList[index];
                return Column(
                  children: [
                    SizedBox(height: 10),
                    SingleItem(
                      isBool: true,
                      img: data.cartImg,
                      name: data.cartName,
                      description: "",
                      price: data.cartPrice,
                      productId: data.cartId,
                      WishList: false,
                      quantity: data.cartQuantity,
                      onDelete: () {
                        showAlertDialog(context, data);
                      },
                    ),
                  ],
                );
              },
            ),
    );
  }
}
