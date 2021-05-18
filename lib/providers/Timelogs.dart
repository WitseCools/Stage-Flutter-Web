// To parse this JSON data, do
//
//     final timelogsForEmployee = timelogsForEmployeeFromJson(jsonString);

import 'dart:convert';

List<TimelogsForEmployee> timelogsForEmployeeFromJson(String str) =>
    List<TimelogsForEmployee>.from(
        json.decode(str).map((x) => TimelogsForEmployee.fromJson(x)));

String timelogsForEmployeeToJson(List<TimelogsForEmployee> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TimelogsForEmployee {
  TimelogsForEmployee({
    this.timelogId,
    this.startAm,
    this.startPm,
    this.stopAm,
    this.stopPm,
    this.date,
    this.total,
    this.locationId,
    this.taskId,
    this.employeeId,
    this.timeLogCatId,
  });

  String timelogId;
  DateTime startAm;
  DateTime startPm;
  DateTime stopAm;
  DateTime stopPm;
  DateTime date;
  int total;
  String locationId;
  String taskId;
  String employeeId;
  String timeLogCatId;

  factory TimelogsForEmployee.fromJson(Map<String, dynamic> json) =>
      TimelogsForEmployee(
        timelogId: json["timelogId"],
        startAm: DateTime.parse(json["startAM"]),
        startPm: DateTime.parse(json["startPM"]),
        stopAm: DateTime.parse(json["stopAM"]),
        stopPm: DateTime.parse(json["stopPM"]),
        date: DateTime.parse(json["date"]),
        total: json["total"],
        locationId: json["locationId"],
        taskId: json["taskId"],
        employeeId: json["employeeId"],
        timeLogCatId: json["timeLogCatId"],
      );

  Map<String, dynamic> toJson() => {
        "timelogId": timelogId,
        "startAM": startAm.toIso8601String(),
        "startPM": startPm.toIso8601String(),
        "stopAM": stopAm.toIso8601String(),
        "stopPM": stopPm.toIso8601String(),
        "date": date.toIso8601String(),
        "total": total,
        "locationId": locationId,
        "taskId": taskId,
        "employeeId": employeeId,
        "timeLogCatId": timeLogCatId,
      };
}
