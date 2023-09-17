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

      return Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                const Color.fromARGB(255, 63, 135, 194),
                Color.fromARGB(255, 49, 169, 224)
              ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Container(
                  margin: EdgeInsets.only(top: 10, left: 25),
                  child: Text(
                    aircraft,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 235, 231, 46),
                    ),
                  ),
                ),
                Spacer(flex: 2),
                Container(
                  margin: EdgeInsets.only(top: 10),
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
                  margin: EdgeInsets.only(top: 10, right: 25),
                  child: Text(
                    passenger,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ),
                Spacer()
              ]),
              Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(bottom: 10, left: 25),
                      child: Text(
                          startTime.hour.toString() +
                              ":" +
                              startTime.minute.toString(),
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 236, 240, 31)))),
                ],
              )
            ],
          ));
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
                height: physicalHeight - 47,
                width: physicalWidth / 2,
                color: Colors.greenAccent,
              )),
          Positioned(
              top: 0,
              left: physicalWidth / 2,
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
              width: physicalWidth / 2,
              top: 28,
              child: Container(child: flights(flightList)))
        ])
      ],
    );

    return Scaffold(
        body: Column(
      children: [buttonSection, flightBox],
    ));
  }
}
