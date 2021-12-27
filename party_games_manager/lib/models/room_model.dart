class RoomModel {
  String? name;
  String? adminName;
  int? nrPlayers;
  int? nrMaxPlayers;
  bool? isPrivate;
  String? password;
  String? game;
  String? state;
  Map<String, dynamic>? players;
  int? nrSpectators;

  RoomModel({
    this.name,
    this.adminName,
    this.nrPlayers,
    this.nrMaxPlayers,
    this.isPrivate,
    this.password,
    this.game,
    this.state,
    this.players,
    this.nrSpectators,
  });

  //Data fetched from firestore
  factory RoomModel.fromMap(map) {
    return RoomModel(
      name: map["Name"],
      adminName: map["AdminName"],
      nrPlayers: map["NrPlayers"],
      nrMaxPlayers: map["MaxPlayers"],
      isPrivate: map["IsPrivate"],
      password: map["Password"],
      game: map["Game"],
      state: map["State"],
      players: map["Players"],
      nrSpectators: map["NrSpectators"],
    );
  }

  // Data sent to firestre
  Map<String, dynamic> toMap() {
    return {
      "Name": name,
      "AdminName": adminName,
      "NrPlayers": nrPlayers,
      "MaxPlayers": nrMaxPlayers,
      "IsPrivate": isPrivate,
      "Password": password,
      "Game": game,
      "State": state,
      "Players": players,
      "NrSpectators": nrSpectators,
    };
  }
}
