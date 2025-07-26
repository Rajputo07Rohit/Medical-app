class DeliveryAddressModel {
  String firstName;
  String lastName;
  String mobileNo;
  String alternateMobileNo;
  String society;
  String street;
  String landmark;
  // String city;
  // String area;
  // String pincode;
  String addressType;

  DeliveryAddressModel({
    required this.addressType,
    // required this.area,
    required this.alternateMobileNo,
    // required this.city,
    required this.firstName,
    required this.landmark,
    required this.lastName,
    required this.mobileNo,
    // required this.pincode,
    required this.street,
    required this.society,
  });
}
