import 'package:flutter/material.dart';
import 'package:realtime_webapp/widgets/employerListCard.dart';

class EmployerListScreen extends StatefulWidget {
  EmployerListScreen({Key key}) : super(key: key);

  @override
  _EmployerListState createState() => _EmployerListState();
}

class _EmployerListState extends State<EmployerListScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(child: EmployerListCard());
  }
}
