import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:medical_app/Screen/search.dart';

import '../models/Product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> mediProductList = [];
  late Product product;

  fatchMediProduct() async {
    List<Product> newList = [];
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("MediProduct").get();
    List<Product> search = [];
    value.docs.forEach(
      (element) {
        product = Product(
          name: element.get("name"),
          img: element.get("img"),
          description: element.get("description"),
          price: element.get("price"),
          productId: element.get("productId"),
        );
        newList.add(product);
        search.add(product);
      },
    );
    mediProductList = newList;
    notifyListeners();
  }

  List<Product> get getMediProductDataList {
    return mediProductList;
  }

  /////////////////////// SEARCH RETURN //////////////////
  List<Product> get getAllitemsearch {
    return mediProductList;
  }
}
