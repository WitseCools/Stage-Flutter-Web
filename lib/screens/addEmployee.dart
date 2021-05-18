import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:realtime_webapp/widgets/addEmployeeCard.dart';

class AddEmployeeScreen extends StatefulWidget {
  static const routeName = '/addEmployeeScreen';
  AddEmployeeScreen({Key key}) : super(key: key);

  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployeeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Employee"),
        backgroundColor: HexColor("#222C4A"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: AddEmployeeCard(),
        ),
      ),
    );
  }
}
