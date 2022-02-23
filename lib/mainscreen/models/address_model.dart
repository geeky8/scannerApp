class AddressModel {
  AddressModel({
    required this.addressFormatted,
    required this.city,
    required this.addressLine,
    // required this.countryCode,
    required this.postalCode,
    required this.subDivision,
  });

  factory AddressModel.fromJson({required Map<String, dynamic> address}) {
    // final address =
    //     (json['shipmentDetails'] as Map<String, dynamic>)['address'];
    return AddressModel(
      addressFormatted: address['formatted'] as String,
      city: address['city'] as String,
      addressLine: address['addressLine'] as String,
      // countryCode: address['countryCode'],
      postalCode: address['postalCode'] as String,
      subDivision: address['subdivision'] as String,
    );
  }

  final String addressFormatted;
  final String city;
  final String addressLine;
  // final String countryCode;
  final String postalCode;
  final String subDivision;
}
