import 'dart:developer';

import 'package:realtime_webapp/providers/employers.dart';
import 'package:realtime_webapp/widgets/loading.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:realtime_webapp/providers/employee.dart';
import 'package:realtime_webapp/providers/employees.dart';
import 'package:realtime_webapp/providers/project.dart';
import 'package:realtime_webapp/providers/projects.dart';
import 'package:realtime_webapp/services/services.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:dio/dio.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import 'package:hexcolor/hexcolor.dart';

class AddProjectCard extends StatefulWidget {
  AddProjectCard({Key key}) : super(key: key);

  @override
  _AddProjectCardState createState() => _AddProjectCardState();
}

List<Employers> _employers = [];

class _AddProjectCardState extends State<AddProjectCard> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Services service = Provider.of<Services>(context, listen: false);
      service.getEmployers().then((value) {
        _employers = value;
      });
    });
  }

  void _submit() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Services service = Provider.of<Services>(context, listen: false);
      Project project = Provider.of<Project>(context, listen: false);

      service.addProject(project);
    });
  }

  @override
  Widget build(BuildContext context) {
    Employers selectedValue;
    final format = DateFormat("yyyy-MM-dd");
    Project project = Provider.of<Project>(context, listen: false);
    Services service = Provider.of<Services>(context, listen: true);

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 15,
              color: HexColor("#222C4A"),
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          width: 700,
          height: 520,
          child: SingleChildScrollView(
            child: Card(
                elevation: 2,
                child: FutureBuilder(
                    future: service.getEmployers(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return Loading();
                      } else
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Add Project",
                                  style: TextStyle(
                                      color: HexColor("#222C4A"),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 500,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextFormField(
                                            controller: _nameController,
                                            onSaved: (newValue) {
                                              project.name = newValue;
                                            },
                                            decoration: InputDecoration(
                                                labelText: "Name Project",
                                                border: OutlineInputBorder()),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            DateTimeField(
                                              decoration: InputDecoration(
                                                  labelText: "End Project",
                                                  border: OutlineInputBorder()),
                                              format: format,
                                              onShowPicker: (context,
                                                  currentValue) async {
                                                final date =
                                                    await showDatePicker(
                                                        context: context,
                                                        firstDate:
                                                            DateTime(1900),
                                                        initialDate:
                                                            currentValue ??
                                                                DateTime.now(),
                                                        lastDate:
                                                            DateTime(2100));
                                                if (date != null) {
                                                  final time = TimeOfDay(
                                                      hour: DateTime.now().hour,
                                                      minute: DateTime.now()
                                                          .minute);
                                                  project.period = date;
                                                  return DateTimeField.combine(
                                                      date, time);
                                                } else {
                                                  project.period = date;
                                                  return currentValue;
                                                }
                                              },
                                            ),
                                            Container(
                                              width: 500,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: FutureBuilder(
                                                  future:
                                                      service.getEmployees(),
                                                  builder: (context,
                                                      AsyncSnapshot snapshot) {
                                                    if (!snapshot.hasData) {
                                                      return Loading();
                                                    } else
                                                      return SearchableDropdown(
                                                        items: _employers
                                                            .map((item) {
                                                          return new DropdownMenuItem<
                                                                  Employers>(
                                                              child: Text(
                                                                  item.name),
                                                              value: item);
                                                        }).toList(),
                                                        isExpanded: true,
                                                        label:
                                                            "Select an employee",
                                                        menuConstraints:
                                                            BoxConstraints
                                                                .tight(Size
                                                                    .fromHeight(
                                                                        250)),
                                                        value: selectedValue,
                                                        dialogBox: false,
                                                        isCaseSensitiveSearch:
                                                            true,
                                                        searchHint: new Text(
                                                          'Select an employee ',
                                                          style: new TextStyle(
                                                              fontSize: 20),
                                                        ),
                                                        onChanged: (value) {
                                                          setState(() {
                                                            selectedValue =
                                                                value;
                                                            project.employer =
                                                                selectedValue;
                                                          });
                                                        },
                                                      );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: RaisedButton(
                                          onPressed: () {
                                            project.startDate = DateTime.now();
                                            _submit();
                                            service.notifyListeners();
                                            Navigator.of(context).pop();
                                          },
                                          color: HexColor("#222C4A"),
                                          child: Text(
                                            "Save",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))
                            ]);
                    })),
          ),
        ),
      ),
    );
  }
}
