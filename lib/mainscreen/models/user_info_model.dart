class UserInfoModel {
  UserInfoModel({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    this.buyerNote,
  });

  factory UserInfoModel.fromMap(
      {required Map<String, dynamic> json, String? buyerNote}) {
    return UserInfoModel(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      buyerNote: buyerNote,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'email': email,
      'buyerNote': buyerNote,

      // 'firstName': jsonEncode(firstName),
      // 'lastName': jsonEncode(lastName),
      // 'phone': jsonEncode(phone),
      // 'email': jsonEncode(email),
    };
  }

  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String? buyerNote;
}
