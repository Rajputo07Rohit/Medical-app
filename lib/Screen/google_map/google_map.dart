import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:medical_app/constants.dart';
import 'package:medical_app/providers/check_out_provider.dart';
import 'package:provider/provider.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({super.key});

  @override
  State<CustomGoogleMap> createState() => _GoogleMapState();
}

class _GoogleMapState extends State<CustomGoogleMap> {
  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  late GoogleMapController controller;
  Location _location = Location();
  void _onMapCreated(GoogleMapController _value) {
    controller = _value;
    _location.onLocationChanged.listen((event) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(event.latitude!, event.longitude!), zoom: 15),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _initialcameraposition,
                ),
                mapType: MapType.normal,
                onMapCreated: _onMapCreated,
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 50,
                  width: double.infinity,
                  margin:
                      EdgeInsets.only(right: 60, left: 10, bottom: 40, top: 40),
                  child: MaterialButton(
                    onPressed: () async {
                      await _location.getLocation().then((value) {
                        setState(() {
                          checkoutProvider.setLocation = value;
                        });
                      });
                      Navigator.of(context).pop();
                    },
                    color: kPrimary,
                    child: Text(
                      "Set Location",
                      style: TextStyle(color: Colors.white),
                    ),
                    shape: StadiumBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
