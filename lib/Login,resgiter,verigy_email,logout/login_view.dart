import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/Login,resgiter,verigy_email,logout/ForgetP.dart';
import 'package:medical_app/Login,resgiter,verigy_email,logout/Routes.dart';
import 'package:medical_app/Screen/main_page.dart';
import 'package:medical_app/main.dart';
import 'package:medical_app/utilities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  //below funciton will help to take the value.
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text("Login"),
    //   ),
    //   body: Column(
    //     children: [
    //       TextField(
    // controller: _email, // Controller is just passing the info here.
    // enableSuggestions:
    //     false, //don't eant any suggestion from the keyboard
    // autocorrect:
    //     false, //dont't want to Autocorrect whatever the user is typing
    // keyboardType: TextInputType
    //     .emailAddress, //will generate "@" sign in the keyboard
    //         decoration: const InputDecoration(hintText: "Enter your E-mail"),
    //       ),
    //       TextField(
    // controller: _password,
    // obscureText: true, //HIDES OUR PASSWORD
    // enableSuggestions:
    //     false, //don't eant any suggestion from the keyboard
    // autocorrect:
    //     false, //dont't want to Autocorrect whatever the user is typing
    //         decoration: const InputDecoration(hintText: "Enter your password "),
    //       ),
    // TextButton(
    //   onPressed: () async {
    //     //below is for initailising the firebase.
    //     final email = _email.text;
    //     final password = _password.text;
    //     try {
    //       // final userCredential = //Existing user
    //       await FirebaseAuth.instance.signInWithEmailAndPassword(
    //         email: email,
    //         password: password,
    //       );
    //       //Below is for the case, when the user have doesn't verify the mail and goes driectly for hte login page.
    //       final user = FirebaseAuth.instance.currentUser;
    //       if (user?.emailVerified ?? false) {
    //         //if user has verified the mail, then navigate him to the next page of the login
    //         Navigator.of(context)
    //             .pushNamedAndRemoveUntil(mainpage, (route) => false);
    //       } else {
    //         //Navigate him to the verify email page.
    //         Navigator.of(context).pushNamedAndRemoveUntil(
    //           verifyEmailRoute,
    //           (route) => false,
    //         );
    //       }
    //       // devtools.log(userCredential.toString());
    //       // print(userCredential);
    //     } on FirebaseAuthException catch (e) {
    //       // print(e.code);
    //       // print(e.runtimeType); //helps to kwow what is the type of error
    //       if (e.code == "user-not-found") {
    //         // devtools.log("UserNotFound");
    //         await showErrorDialog(
    //           context,
    //           "User not found",
    //         );
    //       } else if (e.code == "wrong-password") {
    //         // devtools.log("Something Else happend");
    //         // devtools.log(e.code);
    //         await showErrorDialog(
    //           context,
    //           "Wrong password",
    //         );
    //       } else {
    //         // for the case when the exception is not the above expected ones.
    //         await showErrorDialog(
    //           context,
    //           "Error: ${e.code}",
    //         );
    //       }
    //     } catch (e) {
    //       await showErrorDialog(
    //         context,
    //         e.toString(),
    //       );
    //     }
    //   },
    //   child: const Text("Login"),
    // ),
    // TextButton(
    //     onPressed: () {
    //       Navigator.of(context)
    //           .pushNamedAndRemoveUntil(registerRoute, (route) => false);
    //     },
    //     child: const Text("Not resgistered yet? Register Here!"))
    //     ],
    //   ),
    // );
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/5.png"), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              child: Text(
                "Login",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 55,
                    fontWeight: FontWeight.w700),
              ),
              padding: EdgeInsets.only(left: 35, top: 130),
              margin: EdgeInsets.only(left: 100, top: 20),
            ),
            // SizedBox(
            //   height: 50,
            // ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.42,
                  right: 35,
                  left: 35,
                ),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          fillColor: Color.fromARGB(255, 250, 248, 251),
                          filled: true,
                          hintText: "Enter your Email",
                          hintStyle: TextStyle(fontFamily: 'DM Sans'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40))),
                      controller:
                          _email, // Controller is just passing the info here.
                      enableSuggestions:
                          false, //don't eant any suggestion from the keyboard
                      autocorrect:
                          false, //dont't want to Autocorrect whatever the user is typing
                      keyboardType: TextInputType
                          .emailAddress, //will generate "@" sign in the keyboard
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          fillColor: Color.fromARGB(255, 250, 248, 251),
                          filled: true,
                          hintText: "Enter your Password",
                          hintStyle: TextStyle(fontFamily: 'DM Sans'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40))),
                      controller: _password,
                      obscureText: true, //HIDES OUR PASSWORD
                      enableSuggestions:
                          false, //don't eant any suggestion from the keyboard
                      autocorrect:
                          false, //dont't want to Autocorrect whatever the user is typing
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextButton(
                      onPressed: () async {
                        //below is for initailising the firebase.
                        final email = _email.text;
                        final password = _password.text;
                        try {
                          // final userCredential = //Existing user
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          //Below is for the case, when the user have doesn't verify the mail and goes driectly for hte login page.
                          final user = FirebaseAuth.instance.currentUser;
                          if (user?.emailVerified ?? false) {
                            //if user has verified the mail, then navigate him to the next page of the login
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                mainpage, (route) => false);
                          } else {
                            //Navigate him to the verify email page.
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              verifyEmailRoute,
                              (route) => false,
                            );
                          }
                          // devtools.log(userCredential.toString());
                          // print(userCredential);
                        } on FirebaseAuthException catch (e) {
                          // print(e.code);
                          // print(e.runtimeType); //helps to kwow what is the type of error
                          if (e.code == "user-not-found") {
                            // devtools.log("UserNotFound");
                            await showErrorDialog(
                              context,
                              "User not found",
                            );
                          } else if (e.code == "wrong-password") {
                            // devtools.log("Something Else happend");
                            // devtools.log(e.code);
                            await showErrorDialog(
                              context,
                              "Wrong password",
                            );
                          } else {
                            // for the case when the exception is not the above expected ones.
                            await showErrorDialog(
                              context,
                              "Error: ${e.code}",
                            );
                          }
                        } catch (e) {
                          await showErrorDialog(
                            context,
                            e.toString(),
                          );
                        }
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            // fontFamily: "DM Sans",
                            color: Colors.white,
                            fontSize: 30),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              registerRoute, (route) => false);
                        },
                        child: const Text(
                          "Not resgistered yet? Register Here!",
                          style: TextStyle(
                              // fontFamily: "DM Sans",
                              color: Colors.white,
                              fontSize: 20),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              forgetPassword, (route) => false);
                        },
                        child: const Text(
                          "Forget Password? No worriesss, Tap here.",
                          style: TextStyle(
                              // fontFamily: "DM Sans",
                              color: Colors.black54,
                              fontSize: 16),
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
