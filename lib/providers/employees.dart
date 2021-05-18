import 'dart:convert';

List<Employees> employeesFromJson(String str) =>
    List<Employees>.from(json.decode(str).map((x) => Employees.fromJson(x)));

String employeesToJson(List<Employees> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Employees {
  Employees({
    this.employeeId,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.function,
    this.active,
    this.employeeType,
  });

  String employeeId;
  String firstName;
  String lastName;
  String email;
  String password;
  String function;
  bool active;
  List<EmployeeType> employeeType;

  factory Employees.fromJson(Map<String, dynamic> json) => Employees(
        employeeId: json["employeeId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        password: json["password"],
        function: json["function"],
        active: json["active"],
        employeeType: List<EmployeeType>.from(
            json["employee_type"].map((x) => EmployeeType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "employeeId": employeeId,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "function": function,
        "active": active,
        "employee_type":
            List<dynamic>.from(employeeType.map((x) => x.toJson())),
      };

  @override
  String toString() {
    // TODO: implement toString
    return firstName +
        " " +
        lastName +
        "\n( " +
        function +
        " )" +
        "\nactive: " +
        active.toString();
  }
}

class EmployeeType {
  EmployeeType({
    this.employeeTypeId,
    this.employeeRole,
  });

  String employeeTypeId;
  String employeeRole;

  factory EmployeeType.fromJson(Map<String, dynamic> json) => EmployeeType(
        employeeTypeId: json["employeeTypeId"],
        employeeRole: json["employeeRole"],
      );

  Map<String, dynamic> toJson() => {
        "employeeTypeId": employeeTypeId,
        "employeeRole": employeeRole,
      };
}
