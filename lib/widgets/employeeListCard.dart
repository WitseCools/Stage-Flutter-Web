import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:realtime_webapp/providers/employees.dart';
import 'package:realtime_webapp/widgets/loading.dart';
import '../services/services.dart';

class EmployeeListCard extends StatefulWidget {
  EmployeeListCard({Key key}) : super(key: key);

  @override
  _EmployerListCardState createState() => _EmployerListCardState();
}

List<Employees> _employees;

class _EmployerListCardState extends State<EmployeeListCard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Services service = Provider.of<Services>(context, listen: false);
      service.getEmployees().then((value) {
        _employees = value;
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
                  Text("List of employees",
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
                          future: service.getEmployees(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return Loading();
                            } else
                              return Container(
                                child: ListView.separated(
                                  separatorBuilder: (context, index) => Divider(
                                    color: Colors.black,
                                  ),
                                  shrinkWrap: true,
                                  reverse: true,
                                  primary: false,
                                  itemCount: _employees != null
                                      ? _employees.length
                                      : 0,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListTile(
                                          title: Text(
                                              '${_employees[index].toString()}'),
                                        ));
                                  },
                                ),
                              );
                          },
                        )),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/addEmployeeScreen');
                    },
                    color: HexColor("#222C4A"),
                    child: Text(
                      "Add Employee",
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
