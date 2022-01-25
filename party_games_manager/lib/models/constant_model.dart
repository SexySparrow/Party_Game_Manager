class ConstantModel {
  int? guestNumber;

  ConstantModel({
    this.guestNumber,
  });

  //Data fetched from firestore
  factory ConstantModel.fromMap(map) {
    return ConstantModel(
      guestNumber: map["GuestNumber"],
    );
  }

  // Data sent to firestre
  Map<String, dynamic> toMap() {
    return {
      "GuestNumber": guestNumber,
    };
  }
}
