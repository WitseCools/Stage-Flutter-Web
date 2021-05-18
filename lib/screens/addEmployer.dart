import 'package:flutter/material.dart';
import 'package:realtime_webapp/widgets/addEmployerCard.dart';
import 'package:realtime_webapp/widgets/addLocationCard.dart';
import 'package:realtime_webapp/widgets/employerListCard.dart';
import 'package:realtime_webapp/widgets/locationSelector.dart';
import 'package:hexcolor/hexcolor.dart';

class AddEmployerScreen extends StatefulWidget {
  static const routeName = '/addEmployerScreen';
  AddEmployerScreen({Key key}) : super(key: key);

  @override
  _AddEmployerScreenState createState() => _AddEmployerScreenState();
}

class _AddEmployerScreenState extends State<AddEmployerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Employer"),
        backgroundColor: HexColor("#222C4A"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: AddEmployerCard(),
        ),
      ),
    );
  }
}
