import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:realtime_webapp/providers/currentEmployeeStatics.dart';
import 'package:realtime_webapp/providers/employee.dart';
import 'package:realtime_webapp/providers/employees.dart';
import 'package:realtime_webapp/providers/projects.dart';
import 'package:realtime_webapp/services/services.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:realtime_webapp/widgets/avgCost.dart';
import 'package:realtime_webapp/widgets/loading.dart';
import 'package:realtime_webapp/widgets/timesheetsEmployee.dart';
import 'package:realtime_webapp/widgets/totalHoursGraph.dart';
import 'package:realtime_webapp/widgets/vacactionTimesheetEmployee.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class StatisticsScreen extends StatefulWidget {
  static const routeName = '/viewStatics';
  StatisticsScreen({Key key}) : super(key: key);

  @override
  _StatiscticsScreenState createState() => _StatiscticsScreenState();
}

List<Employees> _employees = [];
List<Projects> _projects = [];
bool showData = false;

class _StatiscticsScreenState extends State<StatisticsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Services service = Provider.of<Services>(context, listen: false);
      service.getEmployees().then((value) {
        print(value.length);
        _employees = value;
      });
    });
  }

  Projects selectedProject;

  @override
  Widget build(BuildContext context) {
    CurrentEmployeeStatistics currentEmployeeStatistics =
        Provider.of<CurrentEmployeeStatistics>(context);
    Employees selectedEmployee;

    Services services = Provider.of<Services>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Specific Statics"),
        backgroundColor: HexColor("#222C4A"),
      ),
      body: Row(
        children: [
          Column(
            children: [
              Card(
                child: Container(
                  width: 400,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 5,
                      color: HexColor("#222C4A"),
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      Text("Select an employee"),
                      FutureBuilder(
                          future: services.getEmployees(),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return Loading();
                            } else
                              return SearchableDropdown(
                                items: _employees.map((item) {
                                  return new DropdownMenuItem<Employees>(
                                      child: Text(item.firstName), value: item);
                                }).toList(),
                                isExpanded: true,
                                menuConstraints:
                                    BoxConstraints.tight(Size.fromHeight(250)),
                                value: selectedEmployee,
                                dialogBox: false,
                                isCaseSensitiveSearch: true,
                                searchHint: new Text(
                                  'Select an employee ',
                                  style: new TextStyle(fontSize: 20),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    selectedEmployee = value;
                                    currentEmployeeStatistics
                                        .setEmployeeId(selectedEmployee);
                                    services
                                        .getProjects(currentEmployeeStatistics
                                            .employeeId)
                                        .then((value) {
                                      _projects = value;
                                    });
                                  });
                                },
                              );
                          }),
                    ],
                  ),
                ),
              ),
              currentEmployeeStatistics.employeeId != null
                  ? FutureBuilder(
                      future: services
                          .getProjects(currentEmployeeStatistics.employeeId),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return Loading();
                        } else
                          return Card(
                            child: Container(
                              width: 400,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 5,
                                  color: HexColor("#222C4A"),
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                children: [
                                  Text("Select an project"),
                                  SearchableDropdown(
                                    items: _projects.map((item) {
                                      return new DropdownMenuItem<Projects>(
                                          child: Text(item.name), value: item);
                                    }).toList(),
                                    isExpanded: true,
                                    menuConstraints: BoxConstraints.tight(
                                        Size.fromHeight(250)),
                                    value: selectedProject,
                                    dialogBox: false,
                                    isCaseSensitiveSearch: true,
                                    searchHint: new Text(
                                      'Select an employee ',
                                      style: new TextStyle(fontSize: 20),
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        selectedProject = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                      })
                  : Text(""),
              currentEmployeeStatistics.employeeId != null
                  ? Card(
                      child: Container(
                        width: 400,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 5,
                            color: HexColor("#222C4A"),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: [
                            Text("Select an begin date"),
                            DateTimePicker(
                              initialValue: '',
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              dateLabelText: 'Start Date',
                              onChanged: (val) {
                                setState(() {
                                  currentEmployeeStatistics.setStartDate(val);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  : Text(""),
              currentEmployeeStatistics.employeeId != null
                  ? Card(
                      child: Container(
                        width: 400,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 5,
                            color: HexColor("#222C4A"),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          children: [
                            Text("Select an end date"),
                            DateTimePicker(
                              initialValue: '',
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              dateLabelText: 'end Date',
                              onChanged: (val) {
                                setState(() {
                                  currentEmployeeStatistics.setEndDate(val);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  : Text(""),
              showData != true
                  ? RaisedButton(
                      onPressed: () {
                        setState(() {
                          showData = true;
                          services
                              .getTotalWorkHours(
                            selectedProject.projectId,
                          )
                              .then((value) {
                            currentEmployeeStatistics
                                .settotalHoursWorked(value.first.totaal);
                          });
                        });
                      },
                      child: Text("Get Data"),
                    )
                  : RaisedButton(
                      onPressed: () {
                        setState(() {
                          showData = false;
                          currentEmployeeStatistics = null;
                          selectedProject = null;
                        });
                      },
                      child: Text("Clear"),
                    )
            ],
          ),
          showData != false
              ? Card(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 5,
                        color: HexColor("#222C4A"),
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: [
                        Text("Total overview"),
                        Container(
                            child: Column(children: [
                          selectedProject != null
                              ? FutureBuilder(
                                  future: services.getTotalWorkHours(
                                      selectedProject.projectId),
                                  builder: (context, snapshot) {
                                    if (snapshot.data == null) {
                                      return Loading();
                                    } else
                                      return Text("Totaal gewerkte uren: " +
                                          currentEmployeeStatistics
                                              .totalHoursWorked
                                              .toString());
                                  })
                              : Text("Nog Niets"),
                          selectedProject != null &&
                                  currentEmployeeStatistics.totalHoursWorked !=
                                      null
                              ? Text("Totaal Loon: " +
                                  (currentEmployeeStatistics.totalHoursWorked *
                                          selectedProject.salary)
                                      .toString())
                              : Text(""),
                          currentEmployeeStatistics.employeeId != null
                              ? TimeSheetEmployee(
                                  employeeId:
                                      currentEmployeeStatistics.employeeId,
                                  startDate:
                                      currentEmployeeStatistics.startDate,
                                  endDate: currentEmployeeStatistics.endDate,
                                )
                              : Text(""),
                          currentEmployeeStatistics.employeeId != null
                              ? Column(
                                  children: [
                                    Text("List vacation"),
                                    VacationTimeSheetEmployee(
                                      employeeId:
                                          currentEmployeeStatistics.employeeId,
                                      startDate:
                                          currentEmployeeStatistics.startDate,
                                      endDate:
                                          currentEmployeeStatistics.endDate,
                                    ),
                                  ],
                                )
                              : Text("")
                        ]))
                      ],
                    ),
                  ),
                )
              : Text("")
        ],
      ),
    );
  }
}
