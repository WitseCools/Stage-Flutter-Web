// To parse this JSON data, do
//
//     final totalProject = totalProjectFromJson(jsonString);

import 'dart:convert';

List<TotalProject> totalProjectFromJson(String str) => List<TotalProject>.from(
    json.decode(str).map((x) => TotalProject.fromJson(x)));

String totalProjectToJson(List<TotalProject> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TotalProject {
  TotalProject({
    this.totaal,
    this.projectName,
  });

  double totaal;
  String projectName;

  factory TotalProject.fromJson(Map<String, dynamic> json) => TotalProject(
        totaal: json["totaal"],
        projectName: json["project_name"],
      );

  Map<String, dynamic> toJson() => {
        "totaal": totaal,
        "project_name": projectName,
      };
  @override
  String toString() {
    // TODO: implement toString
    return projectName + "  " + totaal.toString();
  }
}

// To parse this JSON data, do
//
//     final allProjectTime = allProjectTimeFromJson(jsonString);

List<AllProjectTime> allProjectTimeFromJson(String str) =>
    List<AllProjectTime>.from(
        json.decode(str).map((x) => AllProjectTime.fromJson(x)));

String allProjectTimeToJson(List<AllProjectTime> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllProjectTime {
  AllProjectTime({
    this.name,
    this.totaal,
  });

  String name;
  double totaal;

  factory AllProjectTime.fromJson(Map<String, dynamic> json) => AllProjectTime(
        name: json["name"],
        totaal: json["totaal"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "totaal": totaal,
      };
}

// To parse this JSON data, do
//
//     final avgTask = avgTaskFromJson(jsonString);

List<AvgTask> avgTaskFromJson(String str) =>
    List<AvgTask>.from(json.decode(str).map((x) => AvgTask.fromJson(x)));

String avgTaskToJson(List<AvgTask> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AvgTask {
  AvgTask({
    this.name,
    this.average,
  });

  String name;
  double average;

  factory AvgTask.fromJson(Map<String, dynamic> json) => AvgTask(
        name: json["name"],
        average: json["average"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "average": average,
      };
}

// To parse this JSON data, do
//
//     final totalTimeProjects = totalTimeProjectsFromJson(jsonString);

List<TotalTimeProjects> totalTimeProjectsFromJson(String str) =>
    List<TotalTimeProjects>.from(
        json.decode(str).map((x) => TotalTimeProjects.fromJson(x)));

String totalTimeProjectsToJson(List<TotalTimeProjects> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TotalTimeProjects {
  TotalTimeProjects({
    this.totaal,
    this.projectName,
  });

  int totaal;
  String projectName;

  factory TotalTimeProjects.fromJson(Map<String, dynamic> json) =>
      TotalTimeProjects(
        totaal: json["totaal"],
        projectName: json["project_name"],
      );

  Map<String, dynamic> toJson() => {
        "totaal": totaal,
        "project_name": projectName,
      };
}
