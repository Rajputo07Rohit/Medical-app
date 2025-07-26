import 'package:community_material_icon/community_material_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:medical_app/Login,resgiter,verigy_email,logout/Routes.dart';
import 'package:medical_app/Screen/OrderHis.dart';
import 'package:medical_app/Screen/Wishlist/wish_list.dart';
import 'package:medical_app/Screen/review_cart/Cart.dart';

import 'package:medical_app/constants.dart';
import 'package:medical_app/models/User_model.dart';
import 'package:medical_app/providers/Userdata_store.dart';
import 'package:provider/provider.dart';

enum MenuAction { logout }

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  late UserProvider userProvider;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of(context);
    userProvider.getUserData();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // DrawerHeader(
          //   child: Text('My App'),
          // ),
          Container(
            color: kPrimary,
            width: double
                .infinity, //expand through its parent width which is this drawer
            padding: EdgeInsets.all(20),
            // color: Theme.of(context).primaryColorLight,
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(top: 30, bottom: 10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage(
                            "assets/6.png",
                          ),
                          fit: BoxFit.fill),
                    ),
                  ),
                  // ListView.builder(
                  //     itemCount: userProvider.getUserDataList.length,
                  //     itemBuilder: (context, index) {
                  //       UserModel data = userProvider.getUserDataList[index];
                  // Text(
                  //   "Welcome user",
                  //   // "${data.name}",
                  //   style: TextStyle(color: Colors.white),
                  // ),
                  Text(
                    _firebaseAuth.currentUser?.displayName.toString() ?? '',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.blueGrey),
                  ),
                  Text(
                    _firebaseAuth.currentUser?.email ?? '',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.blueGrey),
                  ),
                  // Text(
                  //   "User-Email",
                  //   // "${data.email}",
                  //   style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
                  // ),
                  //     }),
                ],
              ),
            ),
          ),

          ListTile(
            // leading: Icons.shop,
            title: Text('Review Cart'),
            leading: Icon(
              CommunityMaterialIcons.cart_outline,
              color: Colors.amber[200],
              size: 30,
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ReviewCart()));
              // Implement logout functionality here
            },
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            title: Text('Wishlist'),
            leading: Icon(
              CommunityMaterialIcons.heart_outline,
              color: Colors.red,
              size: 30,
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => WishList()));
              // Implement logout functionality here
            },
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            title: Text('Order history'),
            leading: Icon(
              CommunityMaterialIcons.history,
              color: Colors.blueAccent,
              size: 30,
            ),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => OrderHistory()));
              // Implement logout functionality here
            },
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            title: Text('Logout'),
            leading: Icon(
              Icons.logout_rounded,
              color: Color.fromARGB(255, 155, 196, 156),
            ),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginRoute, (route) => false);
              // Implement logout functionality here
            },
          ),
          SizedBox(
            height: 200,
          ),
          Container(
            height: 350,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Contact Support",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text("Call us:"),
                    SizedBox(
                      width: 10,
                    ),
                    Text("+919112537691"),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Text("Mail us:"),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "medapp@gmail.com",
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      //     child: Column(
      //   children: [
      //     Container(
      //       width: double
      //           .infinity, //expand through its parent width which is this drawer
      //       padding: EdgeInsets.all(20),
      //       color: Theme.of(context).primaryColorLight,
      //       child: Center(
      //         child: Column(
      //           children: [
      //             Container(
      //               width: 100,
      //               height: 100,
      //               margin: EdgeInsets.only(top: 30, bottom: 10),
      //               decoration: BoxDecoration(
      //                 shape: BoxShape.circle,
      //                 image: DecorationImage(
      //                     image: NetworkImage(
      //                       "https://images.pexels.com/photos/13344137/pexels-photo-13344137.jpeg?auto=compress&cs=tinysrgb&w=600",
      //                     ),
      //                     fit: BoxFit.fill),
      //               ),
      //             ),
      //             Text(
      //               "Name of the user",
      //               style: TextStyle(color: Colors.white),
      //             ),
      //             Text(
      //               "User-Email",
      //               style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
      //             )
      //           ],
      //         ),
      //       ),
      //     ),
      //     ListTile(
      //       leading: Icon(Icons.person),
      //       title: Text(
      //         "Profile",
      //         style: TextStyle(
      //           fontSize: 18,
      //         ),
      //       ),
      //       onTap: null,
      //     ),
      //     ListTile(
      //       leading: Icon(Icons.settings),
      //       title: Text(
      //         "Settings",
      //         style: TextStyle(
      //           fontSize: 18,
      //         ),
      //       ),
      //       onTap: null,
      //     ),
      //     ListTile(
      //       leading: Icon(Icons.arrow_back),
      //       title: Text(
      //         "Logout",
      //         style: TextStyle(
      //           fontSize: 18,
      //         ),
      //       ),
      //       onTap: null,
      //     ),
      //   ],
      // )
    );
  }
}
