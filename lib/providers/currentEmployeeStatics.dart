import 'package:flutter/material.dart';

import 'package:realtime_webapp/providers/employees.dart';

class CurrentEmployeeStatistics with ChangeNotifier {
  String employeeId;
  String startDate;
  String endDate;
  double totalHoursWorked = 0;

  void setStartDate(String val) {
    this.startDate = val;
    notifyListeners();
  }

  void setEndDate(String val) {
    this.endDate = val;
    notifyListeners();
  }

  void setEmployeeId(Employees val) {
    this.employeeId = val.employeeId;
    notifyListeners();
  }

  void settotalHoursWorked(double val) {
    this.totalHoursWorked = val;
    notifyListeners();
  }
}
