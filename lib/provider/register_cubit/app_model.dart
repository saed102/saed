class UserModel {
  String? name;

  String? email;

  String? phone;

  String? uid;

  UserModel({
    required this.uid,
    required this.email,
    required this.phone,
    required this.name,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    uid = json["uid"];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "phone": phone,
      "email": email,
      "uid": uid,
    };
  }
}
