import 'package:flutter/material.dart';
import 'package:medical_app/Screen/google_map/google_map.dart';
import 'package:medical_app/constants.dart';
import 'package:medical_app/providers/check_out_provider.dart';
import 'package:medical_app/widgets/DropDown.dart';
import 'package:medical_app/widgets/DropDownCity.dart';
import 'package:medical_app/widgets/custom_text_fileds.dart';
import 'package:provider/provider.dart';

class AddDeliverAddress extends StatefulWidget {
  const AddDeliverAddress({super.key});

  @override
  State<AddDeliverAddress> createState() => _AddDeliverAddressState();
}

enum AddressTypes { Home, Work, Other }

class _AddDeliverAddressState extends State<AddDeliverAddress> {
  var myType = AddressTypes.Home;
  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimary,
          title: Text(
            "Add Delivery Address",
            style: TextStyle(fontSize: 18),
          ),
        ),
        bottomNavigationBar: Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            height: 48,
            // child: checkoutProvider.isloadding == false
            // ?
            child: checkoutProvider.isLoading == false
                ? MaterialButton(
                    onPressed: () {
                      checkoutProvider.validator(context, myType);
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => AddDeliverAddress()));
                    },
                    child: Text(
                      "Add Address",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  )
            // : Center(
            //     child: CircularProgressIndicator(),
            //   ),
            ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: ListView(
            children: [
              CustomTextField(
                labText: "First name",
                controller: checkoutProvider.firstName,
              ),
              CustomTextField(
                labText: "Last name",
                controller: checkoutProvider.lastName,
              ),
              CustomTextField(
                labText: "Mobile No",
                controller: checkoutProvider.mobileNo,
              ),
              CustomTextField(
                labText: "Alternate Mobile No",
                controller: checkoutProvider.alternateMobileNo,
              ),
              CustomTextField(
                labText: "Society",
                controller: checkoutProvider.society,
              ),
              CustomTextField(
                labText: "Street",
                controller: checkoutProvider.street,
              ),
              CustomTextField(
                labText: "Landmark",
                controller: checkoutProvider.landmark,
              ),
              DropdownButtonExample(),
              // CustomTextField(
              //   labText: "City",
              //   controller: checkoutProvider.city,
              // ),
              // CustomTextField(
              //   labText: "Aera",
              //   controller: checkoutProvider.area,
              // ),
              DropdownButtonCity(),
              // CustomTextField(
              //   labText: "Pincode",
              //   controller: checkoutProvider.pincode,
              // ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CustomGoogleMap()),
                  );
                },
                child: Container(
                  height: 47,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      checkoutProvider.setLocation == null
                          ? Text("Set Loaction")
                          : Text("Done!"),
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              ListTile(
                title: Text("Address Type*"),
              ),
              RadioListTile(
                value: AddressTypes.Home,
                groupValue: myType,
                onChanged: (AddressTypes? value) {
                  setState(() {
                    myType = value!;
                  });
                },
                title: Text("Home"),
                secondary: Icon(Icons.home, color: kPrimary),
              ),
              RadioListTile(
                value: AddressTypes.Work,
                groupValue: myType,
                onChanged: (AddressTypes? value) {
                  setState(() {
                    myType = value!;
                  });
                },
                title: Text("Work"),
                secondary: Icon(Icons.work, color: kPrimary),
              ),
              RadioListTile(
                value: AddressTypes.Other,
                groupValue: myType,
                onChanged: (AddressTypes? value) {
                  setState(() {
                    myType = value!;
                  });
                },
                title: Text("Other"),
                secondary: Icon(Icons.devices_other, color: kPrimary),
              ),
            ],
          ),
        ));
  }
}
