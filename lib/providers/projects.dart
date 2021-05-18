import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:realtime_webapp/providers/employers.dart';

List<Projects> projectsFromJson(String str) =>
    List<Projects>.from(json.decode(str).map((x) => Projects.fromJson(x)));

String projectsToJson(List<Projects> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Projects {
  Projects(
      {this.projectId,
      this.period,
      this.startDate,
      this.name,
      this.employerId,
      this.salary});

  String projectId;
  DateTime period;
  DateTime startDate;
  String name;
  String employerId;
  double salary;

  factory Projects.fromJson(Map<String, dynamic> json) => Projects(
      projectId: json["projectId"],
      period: DateTime.parse(json["period"]),
      startDate: DateTime.parse(json["startDate"]),
      name: json["name"],
      salary: json["salary"],
      employerId: json["employerId"]);

  Map<String, dynamic> toJson() => {
        "projectId": projectId,
        "period": period.toIso8601String(),
        "startDate": startDate.toIso8601String(),
        "name": name,
        "salary": salary,
        "employerId": employerId,
      };

  @override
  String toString() {
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedStart = formatter.format(startDate);
    String formattedEnd = formatter.format(period);
    // TODO: implement toString
    return "Project: " +
        name +
        "\nDate: " +
        formattedStart +
        " - " +
        formattedEnd +
        "\nemployer: " +
        "Employer naaam";
  }
}
