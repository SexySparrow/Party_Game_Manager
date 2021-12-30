import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:party_games_manager/controllers/rooms_list_controller.dart';
import 'package:party_games_manager/controllers/user_controller.dart';
import 'package:party_games_manager/models/user_model.dart';
import 'package:party_games_manager/screens/home_screen.dart';
import 'package:party_games_manager/screens/login_screen.dart';
import 'package:party_games_manager/services/database.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Rx<User?> _user;
  String? errorMessage;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(_auth.currentUser);
    _user.bindStream(_auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) async {
    if (user == null) {
      Get.offAll(() => const LoginScreen());
    } else {
      if (user.isAnonymous) {
        int? guestNumber = await Database().getGuestNumber();

        UserModel _userModel = UserModel(
          uid: user.uid,
          email: "",
          name: "Guest$guestNumber",
        );

        if (await Database().createNewUser(_userModel)) {
          Get.find<UserController>().user = _userModel;
        }
      } else {
        Get.find<UserController>().user = await Database().getUser(user.uid);
      }
      Get.find<RoomsListController>().roomsList = await Database().getRooms("");
      Get.offAll(() => const HomeScreen());
    }
  }

  Future<void> loginAnonymous() async {
    try {
      await _auth.signInAnonymously();
    } catch (e) {
      Get.snackbar("About User", "User message",
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text("Guest LogIn failed"),
          messageText: Text(e.toString()));
    }
  }

  void login(email, password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;

        default:
          errorMessage = "An undefined Error happened.";
      }
      Fluttertoast.showToast(msg: errorMessage!);
    }
  }

  void register(email, password, name) async {
    try {
      UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      UserModel _userModel = UserModel(
        name: name,
        email: email,
        uid: _authResult.user!.uid,
      );

      if (await Database().createNewUser(_userModel)) {
        Get.find<UserController>().user = _userModel;
      }
    } catch (e) {
      Get.snackbar("Register User", "Register message",
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Text("Account creation failed"),
          messageText: Text(e.toString()));
    }
  }

  void logout() async {
    if (_user.value!.isAnonymous) {
      await Database().deleteUser(_user.value!.uid);
      await _auth.currentUser!.delete();
    } else {
      await _auth.signOut();
    }
  }

  User? getUser() {
    return _auth.currentUser;
  }
}
