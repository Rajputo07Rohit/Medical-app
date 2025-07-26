// // import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';
import 'package:medical_app/models/delivery_address_model.dart';

class CheckoutProvider with ChangeNotifier {
  bool isLoading = false;
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController alternateMobileNo = TextEditingController();
  TextEditingController society = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController landmark = TextEditingController();
  // TextEditingController city = TextEditingController();
  // TextEditingController area = TextEditingController();
  // TextEditingController pincode = TextEditingController();
  // TextEditingController setLocation = TextEditingController();
  LocationData? setLocation;

  void validator(context, myType) async {
    if (firstName.text.isEmpty) {
      Fluttertoast.showToast(msg: "firstname is empty");
    } else if (lastName.text.isEmpty) {
      Fluttertoast.showToast(msg: "lastname is empty");
    } else if (mobileNo.text.isEmpty) {
      Fluttertoast.showToast(msg: "mobileNo is empty");
    } else if (alternateMobileNo.text.isEmpty) {
      Fluttertoast.showToast(msg: "alternateMobileNo is empty");
    } else if (society.text.isEmpty) {
      Fluttertoast.showToast(msg: "society is empty");
    } else if (street.text.isEmpty) {
      Fluttertoast.showToast(msg: "street is empty");
    } else if (landmark.text.isEmpty) {
      Fluttertoast.showToast(msg: "landmark is empty");
      // } else if (city.text.isEmpty) {
      //   Fluttertoast.showToast(msg: "city is empty");
      // } else if (area.text.isEmpty) {
      //   Fluttertoast.showToast(msg: "area is empty");
      // } else if (pincode.text.isEmpty) {
      // Fluttertoast.showToast(msg: "pincode is empty");
    } else if (setLocation == null) {
      Fluttertoast.showToast(msg: "setLocation is empty!");
    } else {
      isLoading = true;
      notifyListeners();
      await FirebaseFirestore.instance
          .collection("AddDeliverAddress")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set({
        "firstname": firstName.text,
        "lastname": lastName.text,
        "mobileNo": mobileNo.text,
        "alternateMobileNo": alternateMobileNo.text,
        "society": society.text,
        "street": street.text,
        "landmark": landmark.text,
        // "city": city.text,
        // "area": area.text,
        // "pincode": pincode.text,
        "AddressType": myType.toString(),
        "longitude": setLocation?.longitude,
        "latitude": setLocation?.latitude,
        // "setLocation": setLocation.text,
      }).then((value) async {
        isLoading = false;
        notifyListeners();
        await Fluttertoast.showToast(msg: "Add your delivey address");
        Navigator.of(context).pop();
        notifyListeners();
      });
      notifyListeners();
    }
  }

  List<DeliveryAddressModel> deliveryAdressList = [];

  getDeliveryAddressData() async {
    List<DeliveryAddressModel> newList = [];

    DeliveryAddressModel deliveryAddressModel;
    DocumentSnapshot _db = await FirebaseFirestore.instance
        .collection("AddDeliverAddress")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    if (_db.exists) {
      deliveryAddressModel = DeliveryAddressModel(
        addressType: _db.get("AddressType"),
        alternateMobileNo: _db.get("alternateMobileNo"),
        // area: _db.get("area"),
        // city: _db.get("city"),
        firstName: _db.get("firstname"),
        landmark: _db.get("landmark"),
        lastName: _db.get("lastname"),
        mobileNo: _db.get("mobileNo"),
        // pincode: _db.get("pincode"),
        society: _db.get("society"),
        street: _db.get("street"),
      );
      newList.add(deliveryAddressModel);
      notifyListeners();
    }

    deliveryAdressList = newList;
    notifyListeners();
  }

  List<DeliveryAddressModel> get getDeliveryAddressList {
    return deliveryAdressList;
  }
}
