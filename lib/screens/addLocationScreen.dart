import 'package:flutter/material.dart';
import 'package:realtime_webapp/widgets/addLocationCard.dart';
import 'package:hexcolor/hexcolor.dart';

class AddLocationScreen extends StatefulWidget {
  static const routeName = '/addLocation';
  String employerId;
  String employerName;
  AddLocationScreen({Key key, this.employerId, this.employerName})
      : super(key: key);

  @override
  _AddLocationScreenState createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Employer"),
        backgroundColor: HexColor("#222C4A"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: AddLocationCard(
            employerId: widget.employerId,
            employerName: widget.employerName,
          ),
        ),
      ),
    );
  }
}
