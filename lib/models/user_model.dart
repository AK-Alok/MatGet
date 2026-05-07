class UserModel {
  final String uid;
  final String name;
  final String email;
  final String? phone;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.phone,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      uid: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}