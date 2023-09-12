import 'dart:ui';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());
var physicalScreenSize = window.physicalSize;
var physicalWidth = physicalScreenSize.width;
var physicalHeight = physicalScreenSize.height;

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Logbook', home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Column button(Color color, IconData icon, String label) {
      return Column(
        children: [
          Icon(icon, color: color),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ],
      );
    }

    Widget buttonSection = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        button(Colors.black, Icons.flight, "FLIGHTS"),
        button(Colors.black, Icons.person, "PERSONNEL"),
      ],
    );

    Row flight(String pilotName, String aircraft, DateTime startTime,
        [String passenger = ""]) {
      bool end = false;

      return Row(
        children: [
          Container(
            child: Text(
              aircraft,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            child: Text(
              pilotName,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            child: Text(
              passenger,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
        ],
      );
    }

    Widget flightBox = Column(
      children: [
        Stack(alignment: Alignment.topRight, children: [
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: physicalHeight - 46,
                width: physicalWidth / 2,
                color: Colors.greenAccent,
              )),
          Positioned(
              top: 0,
              right: physicalWidth / 2 - 55,
              child: ElevatedButton(
                onPressed: () => {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            scrollable: true,
                            title: const Text("Flight Information"),
                            surfaceTintColor: Colors.blueAccent,
                            content: SizedBox(
                                height: 300,
                                width: 300,
                                child: Form(
                                    child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                        decoration: const InputDecoration(
                                            labelText: "Pilot In Command"),
                                        validator: (String? value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some text';
                                          }
                                        }),
                                    TextFormField(
                                        decoration: const InputDecoration(
                                            labelText: "Passenger"))
                                  ],
                                ))),
                            actions: [
                              ElevatedButton(
                                  child: const Text("Submit"), onPressed: () {})
                            ]);
                      })
                },
                child: Icon(Icons.add),
              ))
        ])
      ],
    );

    @override
    Widget build(BuildContext context) {
      // TODO: implement build
      throw UnimplementedError();
    }

    return Scaffold(
        body: Column(
      children: [buttonSection, flightBox],
    ));
  }
}
