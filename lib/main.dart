// import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/Login,resgiter,verigy_email,logout/ForgetP.dart';
import 'package:medical_app/Login,resgiter,verigy_email,logout/forget_password.dart';
import 'package:medical_app/Login,resgiter,verigy_email,logout/reigster_view.dart';
import 'package:medical_app/Login,resgiter,verigy_email,logout/login_view.dart';
import 'package:medical_app/Screen/drawer.dart';
import 'package:medical_app/Screen/review_cart/Cart.dart';
import 'package:medical_app/Splash_Screen/splashscreen.dart';
import 'package:medical_app/Test/major_project.dart';
import 'package:medical_app/firebase_options.dart';
import 'package:medical_app/Screen/main_page.dart';
import 'package:medical_app/models/Product.dart';
import 'package:medical_app/providers/Userdata_store.dart';
import 'package:medical_app/providers/check_out_provider.dart';
import 'package:medical_app/providers/orderH_provider.dart';
import 'package:medical_app/providers/product_provider.dart';
import 'package:medical_app/providers/review_cart_provider.dart';
import 'package:medical_app/providers/wishlist_provider.dart';
import 'package:provider/provider.dart';
import 'Login,resgiter,verigy_email,logout/Routes.dart';
import 'Login,resgiter,verigy_email,logout/verify_email.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider<ReviewCartProvider>(
            create: (context) => ReviewCartProvider()),
        ChangeNotifierProvider<CheckoutProvider>(
            create: (context) => CheckoutProvider()),
        ChangeNotifierProvider<WishListProvider>(
            create: (context) => WishListProvider()),
        ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider()),
        ChangeNotifierProvider<OrderHisProvider>(
            create: (context) => OrderHisProvider()),
        // ChangeNotifierProvider<UserProvider>(
        //     create: (context) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'Medical Shop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Raleway',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: HomePage(),
        home: SplashScreen(),
        // home: MajorProject(),
        routes: {
          loginRoute: (context) => const LoginView(),
          registerRoute: (context) => const RegisterView(),
          verifyEmailRoute: (context) => const VerifyEmailView(),
          mainpage: (context) => MainPage(),
          // notesRoute: (context) => NotesView(),
          drawer: (context) => MainDrawer(),
          cartRoute: (context) => ReviewCart(),
          forgetPassword: (context) => ForgetPassword(),
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        // Snapshot a/c to me is basically time between button press and next page
        // we have to write the below code, when the connection of the user is slow, it will prompt as "loading..."
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            //FOR EMAIL VERIFICATION
            final user = FirebaseAuth.instance.currentUser;
            // print(user);
            print("hi");
            if (user != null) {
              print("hii");
              if (user.emailVerified) {
                print("Email is verified. Hurrayyyyyyyyy!");
                // return const Text("Done");
                return const MainPage(); //After the email is verified, next page will pop up.
                // return const NotesView();
              } else {
                print("verify1st");
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
          // return const Text("Hi");
          default:
            // return const Text("Loading...");
            return const CircularProgressIndicator(); //alternative for above
        }
      },
    );
  }
}

enum MenuAction { logout }

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => NotesViewState();
}

class NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Main Ui"), actions: [
        PopupMenuButton<MenuAction>(
          onSelected: (value) async {
            // devtools.log(value.toString()); // "log" is an alteranate of print
            switch (value) {
              case MenuAction.logout:
                final shouldLogout = await showLogOutDialog(context);
                // devtools.log(shouldLogout.toString());
                // break;
                if (shouldLogout) {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    "/login/",
                    (_) => false,
                  );
                }
            }
          },
          itemBuilder: (context) {
            return const [
              PopupMenuItem<MenuAction>(
                value: MenuAction.logout,
                child: Text("Logout"),
              ),
            ];
          },
        )
      ]),
      body: const Text("Hello World."),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Sign out"),
        content: const Text("Are you sure you want to sign out?"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("Cancel")),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("Sign out")),
        ],
      );
    },
  ).then((value) =>
      value ??
      false); //this is for the case when, the user tap anywhere else on the screen, on apperaing of the dailog box.
}
