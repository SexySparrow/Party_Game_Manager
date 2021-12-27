import 'package:party_games_manager/models/room_model.dart';
import 'package:get/get.dart';

class RoomsListController extends GetxController {
  final Rx<List<RoomModel>> _rooms = Rx<List<RoomModel>>([]);

  List<RoomModel> get roomsList => _rooms.value;

  set roomsList(List<RoomModel> value) => _rooms.value = value;

  void clear() {
    _rooms.value = [];
  }
}
