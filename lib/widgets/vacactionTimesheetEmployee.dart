import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_webapp/providers/Timelogs.dart';
import 'package:realtime_webapp/providers/VacationTimelog.dart';
import 'package:realtime_webapp/services/services.dart';
import 'package:realtime_webapp/widgets/loading.dart';

class VacationTimeSheetEmployee extends StatefulWidget {
  String employeeId;
  String startDate;
  String endDate;
  VacationTimeSheetEmployee(
      {Key key, this.employeeId, this.startDate, this.endDate})
      : super(key: key);

  @override
  _TimeSheetEmployeeState createState() => _TimeSheetEmployeeState();
}

List<VacationTimelog> _timesheets = [];

class _TimeSheetEmployeeState extends State<VacationTimeSheetEmployee> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Services service = Provider.of<Services>(context, listen: false);
      service
          .getVacationTimeSheets(
              widget.employeeId, widget.startDate, widget.endDate)
          .then((value) {
        _timesheets = value;
        print(value.length);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Services service = Provider.of<Services>(context, listen: false);
    return FutureBuilder(
        future: service.getTimelogsByEmloyee(
            widget.employeeId, widget.startDate, widget.endDate),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Loading();
          } else
            return Container(
                child: ListView.builder(
              shrinkWrap: true,
              reverse: true,
              primary: false,
              itemCount: _timesheets.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text('${_timesheets[index].timelogId}'),
                      ),
                    ));
              },
            ));
        });
  }
}
