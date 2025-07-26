import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:medical_app/models/User_model.dart';

// import '../models/usermod.dart';

class UserProvider with ChangeNotifier {
  static saveUser(String name, email, uid, password) async {
    await FirebaseFirestore.instance
        .collection("Users") //goes to this collection
        .doc(uid) //then goes inside user id
        .set({
      "email": email,
      "name": name,
      "password": password
    }); //lastly sets the fields
  }

  List<UserModel> userdataList = [];
  void getUserData() async {
    List<UserModel> newList = [];
    DocumentSnapshot<Map<String, dynamic>> uservalue = await FirebaseFirestore
        .instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser?.uid) //goes to this collection
        .get();

    UserModel userModel = UserModel(
      name: uservalue.get("name"),
      email: uservalue.get("email"),
      password: uservalue.get("password"),
    );
    newList.add(userModel);

    userdataList = newList;
    notifyListeners();
  }

  List<UserModel> get getUserDataList {
    return userdataList;
  }
}
