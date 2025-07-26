// import 'package:flutter/material.dart';
// import 'package:medical_app/models/Product.dart';
// import 'package:medical_app/widgets/single_item.dart';
// import 'package:medical_app/constants.dart';
// import '../../../Other/constants.dart';

// class Search extends StatefulWidget {
//   late final List<Product> search;

//   Search({required this.search});

//   @override
//   State<Search> createState() => _SearchState();
// }

// class _SearchState extends State<Search> {
//   String query = "";

//   searchItem(String query) {
//     List<Product> searchMedic = widget.search.where((element) {
//       return element.name.toLowerCase().contains(query);
//     }).toList();
//     return searchMedic;
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<Product> _searchItem = searchItem(query);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Search",
//           style: TextStyle(fontWeight: FontWeight.w600),
//         ),
//         backgroundColor: kPrimary,
//       ),
//       body: ListView(
//         children: [
//           ListTile(
//             title: Text(("Items")),
//           ),
//           Container(
//             height: 52,
//             margin: EdgeInsets.symmetric(horizontal: 20),
//             child: TextField(
//               onChanged: (value) {
//                 setState(() {
//                   query = value;
//                 });
//               },
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                   borderSide: BorderSide.none,
//                 ),
//                 fillColor: Color.fromARGB(255, 206, 195, 195),
//                 filled: true,
//                 hintText: "Search medicines here",
//                 suffixIcon: Icon(Icons.search),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Column(
//             children: _searchItem.map((data) {
//               return SingleItem(
//                 isBool: false,
//                 img: data.img,
//                 name: data.name,
//                 description: data.description,
//                 price: data.price,
//               );
//             }).toList(),
//           )
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_icons/flutter_icons.dart';
// import 'package:medical_app/models/Product.dart';

// import '../constants.dart';

// class SingleItem extends StatelessWidget {
//   SingleItem({
//     Key? key,
//     required this.isBool,
//   }) : super(key: key);
//   final isBool;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 10),
//       margin: EdgeInsets.only(bottom: 15),
//       width: MediaQuery.of(context).size.width,
//       decoration: BoxDecoration(
//         color: kTextSecondary,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Color(0xFF073738),
//             offset: Offset(2, 3),
//             blurRadius: 10,
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             flex: 1,
//             child: Image.network(
//               "https://onemg.gumlet.io/l_watermark_346,w_480,h_480/a_ignore,w_480,h_480,c_fit,q_auto,f_auto/cropped/yomslweix3drejlyact9.jpg",
//             ),
//           ),
//           Expanded(
//             flex: 2,
//             child: Column(
//               mainAxisAlignment: isBool == false
//                   ? MainAxisAlignment.spaceAround
//                   : MainAxisAlignment.spaceEvenly,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   "product.name",
//                   style: TextStyle(
//                     color: kTextPrimary,
//                     fontSize: 22,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Text(
//                   "product.description",
//                   style: TextStyle(
//                     color: kTextPrimary,
//                     fontSize: 15,
//                   ),
//                 ),
//                 SizedBox(height: 15),
//                 isBool == false
//                     ? Container(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Text(
//                               // '\u20B9 ' + product.price.toString(),
//                               '\u20B9 ' + "20",
//                               style: TextStyle(
//                                 color: kTextPrimary,
//                                 fontSize: 25,
//                               ),
//                             ),
//                             Icon(
//                               Feather.shopping_cart,
//                               color: kTextPrimary,
//                             ),
//                           ],
//                         ),
//                       )
//                     : Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Text(
//                             // '\u20B9 ' + product.price.toString(),
//                             '\u20B9 ' + "20",
//                             style: TextStyle(
//                               color: kTextPrimary,
//                               fontSize: 25,
//                             ),
//                           ),
//                           Icon(
//                             Feather.shopping_cart,
//                             color: kTextPrimary,
//                           ),
//                           Icon(Feather.delete),
//                         ],
//                       )
//               ],
//             ),
//           ),
//           isBool == false
//               ? Container()
//               : Divider(height: 1, color: Colors.black)
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:medical_app/models/Product.dart';
import 'package:medical_app/widgets/single_item.dart';
import 'package:medical_app/constants.dart';
import '../../../Other/constants.dart';

class Search extends StatefulWidget {
  late final List<Product> search;

  Search({required this.search});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String query = "";

  searchItem(String query) {
    List<Product> searchMedic = widget.search.where((element) {
      return element.name.toLowerCase().contains(query);
    }).toList();
    return searchMedic;
  }

  @override
  Widget build(BuildContext context) {
    List<Product> _searchItem = searchItem(query);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: kPrimary,
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text(("Items")),
          ),
          Container(
            height: 52,
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                fillColor: Color.fromARGB(255, 206, 195, 195),
                filled: true,
                hintText: "Search medicines here",
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: _searchItem.map((data) {
              return SingleItem(
                isBool: false,
                img: data.img,
                name: data.name,
                description: data.description,
                price: data.price,
                productId: data.productId,
                onDelete: () {},
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
