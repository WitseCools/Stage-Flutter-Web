import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:realtime_webapp/providers/employees.dart';
import 'package:realtime_webapp/providers/employers.dart';

class Project with ChangeNotifier {
  String projectId;
  DateTime period;
  DateTime startDate;
  String name;
  Employers employer;
}
