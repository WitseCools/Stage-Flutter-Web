import 'package:flutter/material.dart';
import 'package:realtime_webapp/widgets/addEmployerCard.dart';
import 'package:realtime_webapp/widgets/employeeListCard.dart';

class EmployeeListScreen extends StatefulWidget {
  EmployeeListScreen({Key key}) : super(key: key);

  @override
  _EmployeeListScreenState createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: EmployeeListCard(),
    );
  }
}
