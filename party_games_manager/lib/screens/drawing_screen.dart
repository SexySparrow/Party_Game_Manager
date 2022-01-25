import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:party_games_manager/models/point_data.dart';
import 'package:party_games_manager/services/painter.dart';

class DrawingScreen extends StatefulWidget {
  const DrawingScreen({Key? key}) : super(key: key);

  @override
  _DrawingScreenState createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  List<PointData> pointsList = [];
  Color selectedColor = Colors.black;
  double strokeWidth = 2;

  void selectColor() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Color Picker'),
            content: SingleChildScrollView(
              child: BlockPicker(
                pickerColor: selectedColor,
                onColorChanged: (color) {
                  this.setState(() {
                    selectedColor = color;
                  });
                },
              ),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Close"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.blue,
                  Colors.red,
                ],
              ),
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width * 0.8,
                  height: height * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: GestureDetector(
                    onPanDown: (details) {
                      setState(() {
                        pointsList.add(PointData(
                            paint: Paint()
                              ..color = selectedColor
                              ..strokeWidth = strokeWidth
                              ..strokeCap = StrokeCap.round,
                            point: details.localPosition));
                      });
                    },
                    onPanUpdate: (details) {
                      setState(() {
                        pointsList.add(PointData(
                            paint: Paint()
                              ..color = selectedColor
                              ..strokeWidth = strokeWidth
                              ..strokeCap = StrokeCap.round,
                            point: details.localPosition));
                      });
                    },
                    onPanEnd: (details) {
                      setState(() {
                        pointsList.add(PointData(
                            paint: Paint()
                              ..color = selectedColor
                              ..strokeWidth = strokeWidth
                              ..strokeCap = StrokeCap.round,
                            point: const Offset(-100, -100)));
                      });
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: CustomPaint(
                        painter: Painter(
                            pointsList: pointsList,
                            selectedColor: selectedColor),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  width: width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: selectColor,
                        icon: const Icon(Icons.color_lens_rounded),
                        color: selectedColor,
                      ),
                      Expanded(
                          child: Slider(
                        min: 1,
                        max: 7,
                        activeColor: selectedColor,
                        value: strokeWidth,
                        onChanged: (value) {
                          setState(() {
                            strokeWidth = value;
                          });
                        },
                      )),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              pointsList.clear();
                            });
                          },
                          icon: const Icon(Icons.delete)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
