import 'dart:ui';
import 'package:flutter/material.dart';
import 'flight.dart';

void main() => runApp(MyApp());
var physicalScreenSize = window.physicalSize;
var physicalWidth = physicalScreenSize.width;
var physicalHeight = physicalScreenSize.height;

final flightList = <NewFlight>[];

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

    Widget flight(String pilotName, String aircraft, DateTime startTime,
        [String passenger = ""]) {
      bool end = false;

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Container(
              child: Text(
                aircraft,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            Spacer(flex: 2),
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
            Spacer(),
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
          ]),
          Row(
            children: [
              Container(
                  child: Text(
                      startTime.hour.toString() +
                          ":" +
                          startTime.minute.toString(),
                      style:
                          TextStyle(fontSize: 20, color: Colors.blueAccent))),
            ],
          )
        ],
      );
    }

    Widget flights(List<NewFlight> flightList) {
      return Column(
          children: flightList
              .map((item) => flight(item.pilotName, item.aircraft,
                  item.startTime, item.passengerName))
              .toList());
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
                        NewFlight currentFormData = NewFlight();
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
                                    onChanged: (String pilotInCommand) => {
                                      currentFormData.pilotName = pilotInCommand
                                    },
                                    decoration: const InputDecoration(
                                        labelText: "Pilot In Command"),
                                  ),
                                  TextFormField(
                                      onChanged: (String pax) =>
                                          {currentFormData.passengerName = pax},
                                      decoration: const InputDecoration(
                                          labelText: "Passenger")),
                                  TextFormField(
                                      onChanged: (String aircraft) =>
                                          {currentFormData.aircraft = aircraft},
                                      decoration: const InputDecoration(
                                          labelText: "Aircraft Registration")),
                                ],
                              )),
                            ),
                            actions: [
                              ElevatedButton(
                                  child: const Text("Submit"),
                                  onPressed: () {
                                    currentFormData.startTime = DateTime.now();
                                    flightList.add(currentFormData);
                                    Navigator.pop(context);
                                    Navigator.popAndPushNamed(context, "/");
                                  })
                            ]);
                      })
                },
                child: Icon(Icons.add),
              )),
          Positioned(
              left: physicalWidth / 2,
              top: 0,
              child: Container(
                  width: physicalWidth / 2,
                  padding: EdgeInsets.only(top: 50, left: 75, right: 100),
                  child: flights(flightList)))
        ])
      ],
    );

    return Scaffold(
        body: Column(
      children: [buttonSection, flightBox],
    ));
  }
}
