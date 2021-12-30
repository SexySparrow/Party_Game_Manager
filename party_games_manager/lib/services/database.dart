import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:party_games_manager/models/constant_model.dart';
import 'package:party_games_manager/models/room_model.dart';
import 'package:party_games_manager/models/user_model.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firestore.collection("Users").doc(user.uid).set(user.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<UserModel> getUser(String uid) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection("Users").doc(uid).get();
      return UserModel.fromMap(doc.data());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUser(String uid, UserModel user) async {
    try {
      await _firestore.collection("Users").doc(uid).update({
        "Name": user.name,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteUser(String uid) async {
    try {
      await _firestore.collection("Users").doc(uid).delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> createNewRoom(RoomModel room) async {
    try {
      await _firestore.collection("Rooms").doc(room.name).set(room.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> validateRoomName(RoomModel room) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection("Rooms").doc(room.name).get();

      if (doc.data() == null) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return false;
    }
  }

  Future<RoomModel> getRoom(String roomName) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection("Rooms").doc(roomName).get();
      return RoomModel.fromMap(doc.data());
    } catch (e) {
      rethrow;
    }
  }

  Future<List<RoomModel>> getRooms(String filter) async {
    try {
      if (filter == "") {
        final query = await _firestore.collection("Rooms").get();
        final rooms =
            query.docs.map((doc) => RoomModel.fromMap(doc.data())).toList();
        return rooms;
      } else {
        final query = await _firestore
            .collection("Rooms")
            .where("Name", isGreaterThanOrEqualTo: filter)
            .where("Name", isLessThanOrEqualTo: filter + '\uf8ff')
            .get();
        final rooms =
            query.docs.map((doc) => RoomModel.fromMap(doc.data())).toList();
        return rooms;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<int?> getGuestNumber() async {
    DocumentSnapshot doc =
        await _firestore.collection("Constant").doc("guest").get();
    var number = ConstantModel.fromMap(doc.data()).guestNumber;
    if (number != null) {
      number += 1;
      _firestore
          .collection("Constant")
          .doc("guest")
          .update({"GuestNumber": number});
    }
    return ConstantModel.fromMap(doc.data()).guestNumber;
  }
}
