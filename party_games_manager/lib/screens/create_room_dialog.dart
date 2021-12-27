import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:party_games_manager/controllers/rooms_list_controller.dart';
import 'package:party_games_manager/controllers/user_controller.dart';
import 'package:party_games_manager/models/room_model.dart';
import 'package:party_games_manager/services/database.dart';

class RoomDialog {
  static RoomDialog instance = RoomDialog();
  final _formKeyReg = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  bool isPrivateController = false;
  String? game;
  int? maxPlayers;
  List gamesList = ["Scribble"];
  List maxPlayersList = [3, 4, 5, 6];

  Future openRoomDialog(BuildContext contextTwo) => showDialog(
        context: contextTwo,
        builder: (context) => StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              scrollable: true,
              title: const Text(
                "Room Details",
                textAlign: TextAlign.center,
              ),
              content: SizedBox(
                width: 300,
                child: Form(
                  key: _formKeyReg,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 250,
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Text(
                          "Room Name",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: TextFormField(
                          style: const TextStyle(fontSize: 18),
                          textAlignVertical: const TextAlignVertical(y: 0.5),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Room's name can't be blank";
                            } else if (!RegExp("^[a-zA-Z1-9].{2,}")
                                .hasMatch(value)) {
                              return "Must be atleast 3 characters!";
                            }
                            return null;
                          },
                          controller: _nameController,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            hintText: "Name",
                            fillColor: Colors.white70,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 250,
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Text(
                          "Max Players",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 250,
                            padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                            child: DropdownButtonFormField<int>(
                              decoration: const InputDecoration(
                                fillColor: Colors.white70,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                              hint: const Text("Max Players"),
                              value: maxPlayers,
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 22,
                              validator: (input) {
                                if (input == null) {
                                  return "Please select max. players";
                                }
                              },
                              onChanged: (newValue) {
                                setState(() {
                                  maxPlayers = newValue!;
                                });
                              },
                              items: maxPlayersList.map((value) {
                                return DropdownMenuItem<int>(
                                  value: value,
                                  child: Text(
                                    "$value",
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 250,
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                        child: Text(
                          "Game",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.8),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            hintText: "Select Game",
                            hintStyle: TextStyle(fontSize: 18),
                            fillColor: Colors.white70,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2.0,
                              ),
                            ),
                          ),
                          value: game,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 22,
                          elevation: 16,
                          isExpanded: true,
                          validator: (input) {
                            if (input == null) {
                              return "Please select a game";
                            }
                          },
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              game = newValue!;
                            });
                          },
                          items: gamesList.map((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CheckboxListTile(
                        value: isPrivateController,
                        title: const Text("Private Room"),
                        onChanged: (val) {
                          setState(
                            () {
                              isPrivateController = val as bool;
                              _passwordController.text = "";
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      isPrivateController == false
                          ? const SizedBox()
                          : Container(
                              width: 250,
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                              child: Text(
                                "Password",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.8),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                      isPrivateController == false
                          ? const SizedBox()
                          : Container(
                              padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                              child: TextFormField(
                                style: const TextStyle(fontSize: 18),
                                textAlignVertical:
                                    const TextAlignVertical(y: 0.5),
                                controller: _passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: true,
                                validator: (input) {
                                  if (input!.isEmpty) {
                                    return "Please Enter Password";
                                  }
                                  if (input.length < 3) {
                                    return ("Password should be min. 3 characters long");
                                  }
                                },
                                decoration: const InputDecoration(
                                  hintText: "Password",
                                  fillColor: Colors.white70,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 250,
                        height: 50,
                        decoration: const BoxDecoration(
                          color: Color(0xFF5C8CE6),
                          // color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(35)),
                        ),
                        child: MaterialButton(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(35)),
                          ),
                          child: const Text(
                            "Create Room",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () async {
                            if (_formKeyReg.currentState!.validate()) {
                              final room = RoomModel(
                                name: _nameController.text,
                                adminName: Get.find<UserController>().user.name,
                                nrPlayers: 1,
                                nrMaxPlayers: maxPlayers,
                                isPrivate: isPrivateController,
                                password: isPrivateController == false
                                    ? null
                                    : _passwordController.text,
                                game: game,
                                state: "In Lobby",
                                players: {
                                  "${Get.find<UserController>().user.name}": 0
                                },
                                nrSpectators: 0,
                              );
                              Database().createNewRoom(room);
                              Get.find<RoomsListController>().roomsList =
                                  await Database().getRooms("");
                              Get.back();
                            } else {
                              return;
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
}
