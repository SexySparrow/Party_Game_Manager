import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:party_games_manager/screens/drawing_screen.dart';
import 'package:party_games_manager/screens/login_screen.dart';
import 'package:get/get.dart';
import 'package:party_games_manager/controllers/auth_controller.dart';
import 'package:party_games_manager/controllers/rooms_list_controller.dart';
import 'package:party_games_manager/screens/create_room_dialog.dart';
import 'package:party_games_manager/services/database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  Stream roomsStream = FirebaseFirestore.instance
      .collection("Rooms")
      .snapshots(includeMetadataChanges: true);

  @override
  void initState() {
    super.initState();
    _searchController.addListener(searchRooms);
    roomsStream.listen((event) {
      searchRooms();
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(searchRooms);
    _searchController.dispose();
    super.dispose();
  }

  searchRooms() async {
    Get.find<RoomsListController>().roomsList =
        await Database().getRooms(_searchController.text);
  }

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
                MaterialButton(
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const DrawingScreen()));
                  },
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                  minWidth: 300,
                  child: const Text(
                    "Draw",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
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
                const SizedBox(
                  height: 20,
                ),
                Obx(() => Get.find<RoomsListController>().roomsList.isNotEmpty
                    ? ExpansionPanelList.radio(
                        expandedHeaderPadding: const EdgeInsets.all(10),
                        children: Get.find<RoomsListController>()
                            .roomsList
                            .map((room) {
                          return ExpansionPanelRadio(
                            value: room,
                            headerBuilder: (buildContext, status) {
                              return Container(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${room.name}",
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "${room.nrPlayers}/${room.nrMaxPlayers}",
                                          style: const TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "${room.game}",
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.blueAccent,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "${room.state}",
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.blueAccent,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "Admin: ${room.adminName}",
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                        room.isPrivate!
                                            ? const Text(
                                                "Private",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black54,
                                                ),
                                              )
                                            : const Text(
                                                "Public",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                            body: Container(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            const WidgetSpan(
                                              child: Icon(Icons.visibility,
                                                  size: 22),
                                            ),
                                            TextSpan(
                                              text: "  ${room.nrSpectators}",
                                              style: const TextStyle(
                                                fontSize: 22,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      right: 70,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text(
                                          "Player",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blueAccent,
                                          ),
                                        ),
                                        Text(
                                          "Score",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blueAccent,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    color: Colors.grey,
                                    endIndent: 50,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: room.players!.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                            right: 90,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  room.players!.keys
                                                      .elementAt(index),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "${room.players!.values.elementAt(index)}",
                                                style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        );
                                      })
                                ],
                              ),
                            ),
                          );
                        }).toList(),
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
