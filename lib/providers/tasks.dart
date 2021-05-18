// To parse this JSON data, do
//
//     final tasks = tasksFromJson(jsonString);

import 'dart:convert';

List<Tasks> tasksFromJson(String str) =>
    List<Tasks>.from(json.decode(str).map((x) => Tasks.fromJson(x)));

String tasksToJson(List<Tasks> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tasks {
  Tasks({
    this.taskId,
    this.name,
    this.projectId,
  });

  String taskId;
  String name;
  String projectId;

  factory Tasks.fromJson(Map<String, dynamic> json) => Tasks(
        taskId: json["taskId"],
        name: json["name"],
        projectId: json["projectId"],
      );

  Map<String, dynamic> toJson() => {
        "taskId": taskId,
        "name": name,
        "projectId": projectId,
      };
}
