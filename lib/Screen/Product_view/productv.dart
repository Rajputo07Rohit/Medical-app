import 'package:flutter/material.dart';
import 'package:medical_app/Screen/Product_view/product_overview.dart';
import 'package:medical_app/constants.dart';
import 'package:medical_app/models/Product.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import '../../Other/constants.dart';
import 'package:medical_app/components/ProductCard.dart';

import '../../Reminder.dart';
import '../../providers/product_provider.dart';

class productVi extends StatefulWidget {
  const productVi({super.key});

  @override
  State<productVi> createState() => _productViState();
}

class _productViState extends State<productVi> {
  late ProductProvider productProvider;

  void initState() {
    ProductProvider productProvider = Provider.of(context, listen: false);
    productProvider.fatchMediProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of(context);
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
        backgroundColor: kPrimary,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Feather.chevron_left,
            color: kTextPrimary,
            size: 30,
          ),
        ),
        title: Text(
          'Product',
          style: TextStyle(
            color: kTextPrimary,
            fontSize: 25,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            Text(
              "Medicine",
              style: TextStyle(
                color: kTextPrimary,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: ListView(
                children: productProvider.getMediProductDataList.map(
                  (mediProductList) {
                    return ProductCard(
                      img: mediProductList.img,
                      name: mediProductList.name,
                      description: mediProductList.description,
                      price: mediProductList.price,
                      productId: mediProductList.productId,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductOverview(
                              productId: mediProductList.productId,
                              img: mediProductList.img,
                              name: mediProductList.name,
                              description: mediProductList.description,
                              price: mediProductList.price,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
