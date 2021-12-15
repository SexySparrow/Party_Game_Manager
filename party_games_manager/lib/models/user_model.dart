class UserModel {
  String? email;
  String? name;
  String? uid;

  UserModel({
    this.email,
    this.name,
    this.uid,
  });

  //Data fetched from firestore
  factory UserModel.fromMap(map) {
    return UserModel(
      email: map["Email"],
      name: map["Name"],
      uid: map["UID"],
    );
  }

  // Data sent to firestre
  Map<String, dynamic> toMap() {
    return {
      "Email": email,
      "Name": name,
      "UID": uid,
    };
  }
}
