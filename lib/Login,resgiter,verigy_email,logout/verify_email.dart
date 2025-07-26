import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medical_app/Login,resgiter,verigy_email,logout/Routes.dart';
import 'package:medical_app/constants.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      // why we here use SCAFFOLD??
      appBar: AppBar(
        backgroundColor: kPrimary,
        title: const Text("Verify email"),
      ),
      body: Column(
        children: [
          // const Text(
          //     "We have already send the email verification. Please open it to verify your account."),
          // const Text(
          //     "If you haven't recieved the verification, then tap the button below."),
          Container(
            height: 200,
            width: double.infinity,
            // color: Colors.amber,
            child: Container(
              margin: EdgeInsets.all(3),
              child: Text(
                "We have already send the email verification. Please open it to verify your account."
                "If you haven't recieved the verification, then tap the button below.",
                style: TextStyle(fontSize: 20, color: kSecondary),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              final user = FirebaseAuth.instance.currentUser;
              user?.sendEmailVerification();
            },
            child: const Text(
              "Send email verification",
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold),
            ),
          ),
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance
                  .signOut(); // helps user to signout from the firebase
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
                (route) => false,
              );
            },
            child: const Text(
              "Done? Back to login page then",
              style: TextStyle(fontSize: 22, color: Colors.brown),
            ),
          ),
        ],
      ),
    );
  }
}
