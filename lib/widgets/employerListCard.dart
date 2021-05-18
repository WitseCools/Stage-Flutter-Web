import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:provider/provider.dart';
import 'package:realtime_webapp/providers/employer.dart';
import 'package:realtime_webapp/providers/employers.dart';
import 'package:realtime_webapp/screens/addLocationScreen.dart';
import 'package:realtime_webapp/services/services.dart';
import 'package:realtime_webapp/widgets/loading.dart';

class EmployerListCard extends StatefulWidget {
  EmployerListCard({Key key}) : super(key: key);

  @override
  _EmployeListCardState createState() => _EmployeListCardState();
}

List<Employers> _employers;

class _EmployeListCardState extends State<EmployerListCard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Services service = Provider.of<Services>(context, listen: false);
      service.getLocations().then((value) {
        _employers = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Services service = Provider.of<Services>(context, listen: false);
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            width: 1200,
            height: 800,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text("List of employers",
                      style: TextStyle(
                          color: HexColor("#222C4A"),
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                  Card(
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 15,
                            color: HexColor("#222C4A"),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: FutureBuilder(
                          future: service.getLocations(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Loading();
                            } else
                              return ListView.separated(
                                separatorBuilder: (context, index) => Divider(
                                  color: Colors.black,
                                ),
                                shrinkWrap: true,
                                reverse: true,
                                primary: false,
                                itemCount:
                                    _employers != null ? _employers.length : 0,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                        title: Text(
                                            '${_employers[index].toString()}'),
                                        trailing: Column(
                                          children: [
                                            RaisedButton.icon(
                                                color: HexColor("#222C4A"),
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AddLocationScreen(
                                                                employerId:
                                                                    _employers[
                                                                            index]
                                                                        .employerId,
                                                                employerName:
                                                                    _employers[
                                                                            index]
                                                                        .name)),
                                                  );
                                                },
                                                icon: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                ),
                                                label: Text(
                                                  "Manage locations",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                          ],
                                        )),
                                  );
                                },
                              );
                          },
                        )),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/addEmployerScreen');
                    },
                    color: HexColor("#222C4A"),
                    child: Text(
                      "Add Employer",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
