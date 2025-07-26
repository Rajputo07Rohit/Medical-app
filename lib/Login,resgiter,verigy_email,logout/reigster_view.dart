import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/Login,resgiter,verigy_email,logout/Routes.dart';
import 'package:medical_app/Screen/main_page.dart';
import 'package:medical_app/providers/Userdata_store.dart';
import 'package:medical_app/utilities/show_error_dialog.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _name;
  late final TextEditingController _email;
  late final TextEditingController _password;

  // late UserProvider userProvider;
  //below funciton will help to take the value.
  @override
  void initState() {
    _name = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              child: Text(
                "Register Please",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w700),
              ),
              padding: EdgeInsets.only(left: 35, top: 130),
              margin: EdgeInsets.only(left: 60, top: 20),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.38,
                  right: 35,
                  left: 35,
                ),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          fillColor: Color.fromARGB(255, 250, 248, 251),
                          filled: true,
                          hintText: "Your Name Please",
                          hintStyle: TextStyle(fontFamily: 'DM Sans'),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40))),
                      controller: _name,
                    ),
                    SizedBox(
                      height: 30,
                    ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () async {
                              //below is for initailising the firebase.
                              final name = _name.text;
                              // print(name);
                              final email = _email.text;
                              print("heyaaaaaa");
                              final password = _password.text;
                              try {
                                UserCredential userCredentails = await FirebaseAuth
                                    .instance
                                    .createUserWithEmailAndPassword(
                                        //Creating user
                                        //We need to initialise the Firebase before calling so we written statment from line 74->76
                                        //need to use "await" as it will happen in future, not right now.
                                        email: email,
                                        password: password);
                                await FirebaseAuth.instance.currentUser!
                                    .updateDisplayName(name);
                                await FirebaseAuth.instance.currentUser!
                                    .updateEmail(email);
                                await FirebaseAuth.instance.currentUser!
                                    .updatePassword(password);
                                await UserProvider.saveUser(name, email,
                                    userCredentails.user!.uid, password);
                                final user = FirebaseAuth.instance.currentUser;
                                user?.sendEmailVerification();
                                // the above 2 lines will automatically send the verification to user, without actually pressing the button by the user.
                                Navigator.of(context)
                                    .pushNamed(verifyEmailRoute);

                                // devtools.log(userCredential.toString());
                              } on FirebaseAuthException catch (e) {
                                // print(e); //is use to detech what is the type fo error can happen from user end
                                //to hand those error it is write with e.code
                                if (e.code == "invalid-email") {
                                  // devtools.log("Invalid email");
                                  await showErrorDialog(
                                    context,
                                    "Enter a valid email",
                                  );
                                } else if (e.code == "weak-password") {
                                  // devtools.log("Weak Password");
                                  await showErrorDialog(
                                    context,
                                    "Weak password. Make something difficult.",
                                  );
                                } else {
                                  //When the email id is already registered
                                  // devtools.log("User already present.");
                                  await showErrorDialog(
                                    context,
                                    "Error ${e.code}",
                                  );
                                }
                              } catch (e) {
                                e.toString();
                              }
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(
                                  fontFamily: "DM Sans",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 25,
                                  color: Color.fromARGB(255, 235, 227, 227)),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(loginRoute);
                            },
                            child: Text(
                              "Already registered?Tap to login !",
                              style: TextStyle(
                                  fontFamily: "DM Sans",
                                  // fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ))
                      ],
                    )
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
