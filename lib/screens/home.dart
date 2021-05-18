import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:realtime_webapp/widgets/avgCost.dart';
import 'package:realtime_webapp/widgets/totalHoursGraph.dart';
import 'package:realtime_webapp/widgets/totalTimeProjectsGraph.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Algemeen overzicht",
              style: TextStyle(
                  color: HexColor("#222C4A"),
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          child: Card(
              child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Column(
                  children: [
                    Text(
                      "Gepresteerde tijd per taak",
                      style: TextStyle(
                          color: HexColor("#222C4A"),
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                            child: Column(
                          children: [
                            TotalHoursGraph(),
                          ],
                        ))),
                  ],
                ),
              ],
            ),
          )),
        ),
        Card(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    "Gemiddelde tijd per taak in uren ",
                    style: TextStyle(
                        color: HexColor("#222C4A"),
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ),
                  AvgCostGraph(),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Totaal gepresteerder tijd in een project ",
                    style: TextStyle(
                        color: HexColor("#222C4A"),
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ),
                  TotalTimeProjectsGraph()
                ],
              ),
            ],
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/viewStatics');
              },
              child: Text(
                "Get specific data",
                style: TextStyle(color: Colors.white),
              ),
              color: HexColor("#222C4A"),
            ),
          ),
        )
      ],
    );
  }
}
