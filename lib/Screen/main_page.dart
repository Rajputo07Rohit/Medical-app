// import 'dart:js';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:medical_app/Reminder.dart';
import 'package:medical_app/Screen/OrderHis.dart';
import 'package:medical_app/Screen/drawer.dart';
import 'package:medical_app/Screen/review_cart/Cart.dart';
import 'package:medical_app/components/CategoryCard.dart';
import 'package:medical_app/Screen/search.dart';
import 'package:medical_app/models/Product.dart';
import 'package:medical_app/models/User_model.dart';
import 'package:medical_app/providers/Userdata_store.dart';
import 'package:medical_app/providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'Product_view/productv.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late ProductProvider productProvider;
  late UserProvider userProvider;

  void initState() {
    ProductProvider productProvider = Provider.of(context, listen: false);
    productProvider.fatchMediProduct();
    super.initState();
  }

  int activeIndex = 0;
  final imgList = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ2aUP53HC7v7P3KZCBCfQl2CMWsk77tNZJhA",
    "https://static.vecteezy.com/system/resources/previews/000/297/920/original/vector-set-of-various-medicines.jpg",
    "https://images.newscientist.com/wp-content/uploads/2019/06/18153152/medicineshutterstock_1421041688.jpg",
  ];
  late File _image;
  final imagePicker = ImagePicker();
  Future getImage() async {
    final image = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of(context);
    userProvider.getUserData();
    productProvider = Provider.of(context);
    return Scaffold(
      drawer: const MainDrawer(),
      backgroundColor: kPrimary,
      appBar: AppBar(
        backgroundColor: kPrimary,
        elevation: 0,
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.of(context).pushNamed(drawer);
        //   },
        //   icon: Transform.rotate(
        //     angle: 3.14 / 2,
        //     child: Icon(
        //       Feather.bar_chart_2,
        //       color: kTextPrimary,
        //       size: 30,
        //     ),
        //   ),
        // ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Search(
                    search: productProvider.getMediProductDataList,
                  ),
                ),
              );
            },
            icon: Icon(
              Feather.search,
              color: kTextPrimary,
              size: 20,
            ),
          ),
        ],
      ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 20),
//             Text(
//               // 'Hi! John',
//               "Hi John",
//               style: TextStyle(
//                 color: kTextPrimary,
//                 fontSize: 30,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Deliver to',
//               style: TextStyle(
//                 color: Colors.grey,
//                 fontSize: 15,
//               ),
//             ),
//             Row(
//               children: [
//                 Text(
//                   'Current location',
//                   style: TextStyle(
//                     color: kTextPrimary,
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Icon(
//                   Feather.chevron_down,
//                   color: kTextPrimary,
//                   size: 20,
//                 ),
//               ],
//             ),
//             SizedBox(height: 10),
//             Container(
//               height: 230,
//               width: double.infinity,
//               color: Colors.transparent,
//               child: Column(children: [
//                 CarouselSlider(
//                   items: imgList
//                       .map((item) => Image.network(
//                             item,
//                             fit: BoxFit.cover,
//                             width: double.infinity,
//                           ))
//                       .toList(),
//                   options: CarouselOptions(
//                       height: 200,
//                       autoPlay: true,
//                       enlargeCenterPage: true,
//                       onPageChanged: (index, reason) {
//                         // for creating dots
//                         setState(() {
//                           activeIndex = index;
//                         });
//                       }),
//                 ),
//                 const SizedBox(height: 20),
//                 buildIndicator(),
//               ]),
//             ),
//             SizedBox(height: 20),
//             ClipRRect(
//               borderRadius: BorderRadius.circular(20),
//               child: TextButton(
//                 onPressed: () {},
//                 // padding: EdgeInsets.symmetric(horizontal: 15, vertical: 22),
//                 // color: kSecondary,
//                 // splashColor: kPrimary,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Feather.camera,
//                       color: kTextPrimary,
//                       size: 25,
//                     ),
//                     SizedBox(width: 10),
//                     Text(
//                       'Upload your prescription',
//                       style: TextStyle(
//                         color: kTextPrimary,
//                         fontSize: 20,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Categories',
//                   style: TextStyle(
//                     color: kTextPrimary,
//                     fontSize: 20,
//                   ),
//                 ),
//                 GestureDetector(
//                   // onTap: () {
//                   //   Navigator.of(context).push(
//                   //     MaterialPageRoute(
//                   //       builder: (context) => Search(
//                   //         search: productProvider.getMediProductDataList,
//                   //       ),
//                   //     ),
//                   //   );
//                   // },
//                   child: Text(
//                     'View all',
//                     style: TextStyle(
//                       color: kTextSecondary,
//                       fontSize: 15,
//                       fontWeight: FontWeight.bold,
//                       decoration: TextDecoration.underline,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 15),
//             Container(
//               height: 125,
//               child: ListView(
//                 shrinkWrap: true,
//                 scrollDirection: Axis.horizontal,
//                 children: [
//                   CategoryCard(
//                     title: 'Medicine',
//                     icon: MaterialCommunityIcons.medical_bag,
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => productVi(),
//                         ),
//                       );
//                     },
//                   ),
//                   // CategoryCard(
//                   //   title: 'My Cart',
//                   //   icon: MaterialCommunityIcons.cart,
//                   //   onPressed: () {
//                   //     Navigator.push(
//                   //       context,
//                   //       MaterialPageRoute(
//                   //         builder: (context) => ReviewCart(),
//                   //       ),
//                   //     );
//                   //   },
//                   // ),
//                   CategoryCard(
//                     title: 'Order History',
//                     icon: Feather.activity,
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => Reminder(),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 15),
//             // Text(
//             //   "Today's deals",
//             //   style: TextStyle(
//             //     color: kTextPrimary,
//             //     fontSize: 20,
//             //   ),
//             // ),
//             // SizedBox(height: 15),
//             // Expanded(
//             //   child: ListView.builder(
//             //     shrinkWrap: true,
//             //     itemCount: products.length,
//             //     itemBuilder: (context, index) =>
//             //         ProductCard(product: products[index]),
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: kSecondary,
//         splashColor: kPrimary,
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => Reminder(),
//             ),
//           );
//         },
//         child: Icon(
//           Icons.alarm_add,
//           color: kTextPrimary,
//           size: 30,
//         ),
//       ),
//     );
//   }

//   //written for creating dot
//   Widget buildIndicator() => AnimatedSmoothIndicator(
//         activeIndex: activeIndex,
//         count: imgList.length,
//         effect: WormEffect(
//           dotWidth: 10,
//           dotHeight: 10,
//           activeDotColor: const Color.fromARGB(255, 54, 51, 51),
//           dotColor: Color.fromARGB(255, 82, 123, 83),
//         ),
//       );
// }

      body: userProvider.getUserDataList.isEmpty
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Loading..',
                      style: TextStyle(
                        color: kTextPrimary,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                  ]),
            )
          : ListView.builder(
              itemCount: userProvider.getUserDataList.length,
              itemBuilder: (context, index) {
                UserModel data = userProvider.getUserDataList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text(
                        "Hi ${data.name}! ",
                        style: TextStyle(
                          color: kTextPrimary,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      // Text(
                      //   'Deliver to',
                      //   style: TextStyle(
                      //     color: Colors.grey,
                      //     fontSize: 15,
                      //   ),
                      // ),
                      // Row(
                      //   children: [
                      //     Text(
                      //       'Current location',
                      //       style: TextStyle(
                      //         color: kTextPrimary,
                      //         fontSize: 15,
                      //         fontWeight: FontWeight.bold,
                      //       ),
                      //     ),
                      //     Icon(
                      //       Feather.chevron_down,
                      //       color: kTextPrimary,
                      //       size: 20,
                      //     ),
                      //   ],
                      // ),
                      SizedBox(height: 10),
                      Container(
                        height: 230,
                        width: double.infinity,
                        color: Colors.transparent,
                        child: Column(children: [
                          CarouselSlider(
                            items: imgList
                                .map((item) => Image.network(
                                      item,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ))
                                .toList(),
                            options: CarouselOptions(
                                height: 200,
                                autoPlay: true,
                                enlargeCenterPage: true,
                                onPageChanged: (index, reason) {
                                  // for creating dots
                                  setState(() {
                                    activeIndex = index;
                                  });
                                }),
                          ),
                          const SizedBox(height: 20),
                          buildIndicator(),
                        ]),
                      ),
                      SizedBox(height: 20),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: TextButton(
                          onPressed: () {},
                          // padding: EdgeInsets.symmetric(horizontal: 15, vertical: 22),
                          // color: kSecondary,
                          // splashColor: kPrimary,
                          child: GestureDetector(
                            onTap: () {
                              getImage();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Feather.camera,
                                  color: kTextPrimary,
                                  size: 22,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Upload your prescription',
                                  style: TextStyle(
                                    color: kTextPrimary,
                                    fontSize: 15,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Categories',
                            style: TextStyle(
                              color: kTextPrimary,
                              fontSize: 20,
                            ),
                          ),
                          GestureDetector(
                            // onTap: () {
                            //   Navigator.of(context).push(
                            //     MaterialPageRoute(
                            //       builder: (context) => Search(
                            //         search: productProvider.getMediProductDataList,
                            //       ),
                            //     ),
                            //   );
                            // },
                            child: Text(
                              'View all',
                              style: TextStyle(
                                color: kTextSecondary,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Container(
                        height: 125,
                        child: ListView(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          children: [
                            CategoryCard(
                              title: 'Medicine',
                              icon: MaterialCommunityIcons.medical_bag,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => productVi(),
                                  ),
                                );
                              },
                            ),
                            CategoryCard(
                              title: 'My Cart',
                              icon: MaterialCommunityIcons.cart,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReviewCart(),
                                  ),
                                );
                              },
                            ),
                            CategoryCard(
                              title: 'Order History',
                              icon: Feather.activity,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OrderHistory(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      // Text(
                      //   "Today's deals",
                      //   style: TextStyle(
                      //     color: kTextPrimary,
                      //     fontSize: 20,
                      //   ),
                      // ),
                      // SizedBox(height: 15),
                      // Expanded(
                      //   child: ListView.builder(
                      //     shrinkWrap: true,
                      //     itemCount: products.length,
                      //     itemBuilder: (context, index) =>
                      //         ProductCard(product: products[index]),
                      //   ),
                      // ),
                    ],
                  ),
                );
              }),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: kSecondary,
      //   splashColor: kPrimary,
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => Reminder(),
      //       ),
      //     );
      //   },
      //   child: Icon(
      //     Icons.alarm_add,
      //     color: kTextPrimary,
      //     size: 30,
      //   ),
      // ),
    );
  }

  //written for creating dot
  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: imgList.length,
        effect: WormEffect(
          dotWidth: 10,
          dotHeight: 10,
          activeDotColor: const Color.fromARGB(255, 54, 51, 51),
          dotColor: Color.fromARGB(255, 82, 123, 83),
        ),
      );
}
