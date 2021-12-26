import 'package:cloud_firestore/cloud_firestore.dart';
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
}
