import 'package:flutter/material.dart';
import 'package:medical_app/constants.dart';
import 'package:hexcolor/hexcolor.dart';

class MajorProject extends StatefulWidget {
  const MajorProject({super.key});

  @override
  State<MajorProject> createState() => _MajorProjectState();
}

class _MajorProjectState extends State<MajorProject> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Demo"),
        backgroundColor: HexColor("#FFD3B0"),
      ),
      body: Container(
        height: 350,
        color: HexColor("F5EBEB"),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: TextButton(
                child: Text(
                  "TextButton",
                  style: TextStyle(fontSize: 15, color: kPrimary),
                ),
                onPressed: () {},
              ),
            ),
            Container(
              child: ElevatedButton(
                child: Text(
                  "ElevatedButton",
                  style: TextStyle(fontSize: 15, color: kTextPrimary),
                ),
                onPressed: () {},
              ),
            ),
            Container(
              child: OutlinedButton(
                child: Text(
                  "OutlinedButton",
                  style: TextStyle(fontSize: 15, color: kPrimary),
                ),
                onPressed: () {},
              ),
            )
          ],
        ),

        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Expanded(
        //       flex: 2,
        //       child: Container(
        //         width: 50,
        //         height: 100,
        //         color: HexColor("FF6969"),
        //       ),
        //     ),
        //     Expanded(
        //       flex: 4,
        //       child: Container(
        //         width: 50,
        //         height: 100,
        //         color: HexColor("E3F2C1"),
        //       ),
        //     ),
        //     Expanded(
        //       flex: 1,
        //       child: Container(
        //         width: 50,
        //         height: 100,
        //         color: HexColor("F9D949"),
        //       ),
        //     ),
        //     Expanded(
        //       flex: 1,
        //       child: Container(
        //         width: 50,
        //         height: 100,
        //         color: HexColor("E8A0BF"),
        //       ),
        //     ),
        //   ],
        // height: 200,
        // width: 200,
        // color: kPrimary,
        // child: Text(
        //   "Hello World",
        //   style: TextS;tyle(color: kTextPrimary, fontSize: 20),
        // ),
        // height: 300,
        // width: 300,
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     Text(
        //       "Hello",
        //       style: TextStyle(fontSize: 25),
        //     ),
        //     Text(
        //       "How",
        //       style: TextStyle(fontSize: 25),
        //     ),
        //     Text(
        //       "Are",
        //       style: TextStyle(fontSize: 25),
        //     ),
        //     Text(
        //       "You?",
        //       style: TextStyle(fontSize: 25),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
