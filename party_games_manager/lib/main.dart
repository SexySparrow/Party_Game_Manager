import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:party_games_manager/controllers/auth_controller.dart';
import 'package:party_games_manager/controllers/room_controller.dart';
import 'package:party_games_manager/controllers/rooms_list_controller.dart';
import 'package:party_games_manager/controllers/user_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => {
        Get.put(AuthController()),
        Get.put(UserController()),
        Get.put(RoomsListController()),
        Get.put(RoomController()),
      });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: CircularProgressIndicator(),
    );
  }
}
