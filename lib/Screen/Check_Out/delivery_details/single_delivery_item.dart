import 'package:flutter/material.dart';
import 'package:medical_app/constants.dart';

class SingleDeliveryItem extends StatelessWidget {
  const SingleDeliveryItem(
      {Key? key,
      required this.title,
      required this.address,
      required this.number,
      required this.addressType})
      : super(key: key);

  final String title;
  final String address;
  final String number;
  final String addressType;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Container(
                  width: 60,
                  padding: EdgeInsets.all(1),
                  height: 20,
                  decoration: BoxDecoration(
                    color: kPrimary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      addressType,
                      style: TextStyle(fontSize: 13, color: Colors.white),
                    ),
                  )),
            ],
          ),
          leading: CircleAvatar(
            backgroundColor: kPrimary,
            radius: 8,
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(address),
              SizedBox(
                height: 5,
              ),
              Text(number),
            ],
          ),
        ),
        Divider(
          height: 35,
        ),
      ],
    );
  }
}
