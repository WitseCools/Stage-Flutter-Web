import 'dart:convert';

List<VacationTimelog> vacatinTimelogFromJson(String str) =>
    List<VacationTimelog>.from(
        json.decode(str).map((x) => VacationTimelog.fromJson(x)));

String vacatinTimelogToJson(List<VacationTimelog> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VacationTimelog {
  VacationTimelog({
    this.timelogId,
    this.startAm,
    this.stopPm,
    this.total,
    this.employeeId,
    this.timeLogCatId,
  });

  String timelogId;
  DateTime startAm;
  DateTime stopPm;
  int total;
  String employeeId;
  String timeLogCatId;

  factory VacationTimelog.fromJson(Map<String, dynamic> json) =>
      VacationTimelog(
        timelogId: json["timelogId"],
        startAm: DateTime.parse(json["startAM"]),
        stopPm: DateTime.parse(json["stopPM"]),
        total: json["total"],
        employeeId: json["employeeId"],
        timeLogCatId: json["timeLogCatId"],
      );

  Map<String, dynamic> toJson() => {
        "timelogId": timelogId,
        "startAM": startAm.toIso8601String(),
        "stopPM": stopPm.toIso8601String(),
        "total": total,
        "employeeId": employeeId,
        "timeLogCatId": timeLogCatId,
      };
}
