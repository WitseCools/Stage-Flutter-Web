import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:realtime_webapp/providers/employees.dart';
import 'package:realtime_webapp/providers/project.dart';
import 'package:realtime_webapp/providers/projects.dart';
import 'package:realtime_webapp/services/services.dart';
import 'package:realtime_webapp/widgets/addProjectCard.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import 'package:hexcolor/hexcolor.dart';

class AddProjectScreen extends StatefulWidget {
  static const routeName = '/addProject';

  AddProjectScreen({Key key}) : super(key: key);

  @override
  _AddProjectState createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProjectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Project"),
        backgroundColor: HexColor("#222C4A"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: AddProjectCard(),
        ),
      ),
    );
  }
}
