import 'dart:convert';
import 'package:intl/intl.dart';

List<Employers> employersFromJson(String str) =>
    List<Employers>.from(json.decode(str).map((x) => Employers.fromJson(x)));

String employersToJson(List<Employers> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Employers {
  Employers({this.name, this.date, this.employerId});

  String name;
  DateTime date;
  String employerId;

  factory Employers.fromJson(Map<String, dynamic> json) => Employers(
      name: json["name"],
      date: DateTime.parse(json["date"]),
      employerId: json["employerId"]);

  Map<String, dynamic> toJson() =>
      {"name": name, "date": date.toIso8601String(), "employerId": employerId};

  @override
  String toString() {
    // TODO: implement toString
    var formatter = new DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(date);
    return "Name: " + name + "\nDate: " + formatted;
  }
}
