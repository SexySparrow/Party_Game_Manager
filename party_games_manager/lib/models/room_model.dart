class UserModel {
  String name;
  String adminName;
  int nrPlayers;
  int nrMaxPlayers;
  String game;
  String state;
  Map<String, int> players;
  int nrSpectators;
  String uid;

  UserModel({
    required this.name,
    required this.adminName,
    required this.nrPlayers,
    required this.nrMaxPlayers,
    required this.game,
    required this.state,
    required this.players,
    required this.nrSpectators,
    required this.uid,
  });

  //Data fetched from firestore
  factory UserModel.fromMap(map) {
    return UserModel(
      name: map["Name"],
      adminName: map["AdminName"],
      nrPlayers: map["NrPlayers"],
      nrMaxPlayers: map["MaxPlayers"],
      game: map["Game"],
      state: map["State"],
      players: map["Players"],
      nrSpectators: map["NrSpectators"],
      uid: map["UID"],
    );
  }

  // Data sent to firestre
  Map<String, dynamic> toMap() {
    return {
      "Name": name,
      "AdminName": adminName,
      "NrPlayers": nrPlayers,
      "MaxPlayers": nrMaxPlayers,
      "Game": game,
      "State": state,
      "Players": players,
      "NrSpectators": nrSpectators,
      "UID": uid,
    };
  }
}
