import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:realtime_webapp/providers/employees.dart';

class Employee with ChangeNotifier {
  String employeeId;
  String firstName;
  String lastName;
  String email;
  String password;
  String function;
  bool active;
  String employeeType;
  String startDate;
  String endDate;

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
}
