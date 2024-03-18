class User {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String idNumber;
  final String referralCode;
  final String password;
  final String otp;
  final String verified;
  final String createdAt;
  final String userCategory;

  User({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.idNumber,
    required this.referralCode,
    required this.password,
    required this.otp,
    required this.verified,
    required this.createdAt,
    required this.userCategory,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      name: json['name'].toString(),
      phone: json['phone'].toString(),
      email: json['email'].toString(),
      idNumber: json['id_number'].toString(),
      referralCode: json['referral_code'].toString(),
      password: json['password'].toString(),
      otp: json['otp'].toString(),
      verified: json['verified'].toString(),
      createdAt: json['created_at'].toString(),
      userCategory: json['user_category'].toString(),
    );
  }

  // Serialize user object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'id_number': idNumber,
      'referral_code': referralCode,
      'password': password,
      'otp': otp,
      'verified': verified,
      'created_at': createdAt,
      'user_category': userCategory,
    };
  }
}
