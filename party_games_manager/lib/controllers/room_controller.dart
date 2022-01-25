import 'package:get/get.dart';
import 'package:party_games_manager/models/room_model.dart';

class RoomController extends GetxController {
  final Rx<RoomModel> _roomModel = RoomModel().obs;

  RoomModel get room => _roomModel.value;

  set room(RoomModel value) => _roomModel.value = value;

  void clear() {
    _roomModel.value = RoomModel();
  }
}
