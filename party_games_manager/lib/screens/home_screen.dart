import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:party_games_manager/controllers/auth_controller.dart';
import 'package:party_games_manager/controllers/rooms_list_controller.dart';
import 'package:party_games_manager/screens/create_room_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Create New Room"),
        icon: const Icon(Icons.add),
        onPressed: () {
          RoomDialog.instance.openRoomDialog(context);
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Welcome'),
        actions: [
          IconButton(
            onPressed: () {
              AuthController.instance.logout();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 500,
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
            ),
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search a room party',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(35)),
                      ),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                Obx(() => Get.find<RoomsListController>().roomsList.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount:
                            Get.find<RoomsListController>().roomsList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              onTap: () {},
                              title: Text(Get.find<RoomsListController>()
                                  .roomsList[index]
                                  .name!),
                            ),
                          );
                        },
                      )
                    : const SizedBox()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
