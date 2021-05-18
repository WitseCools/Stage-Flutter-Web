import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:realtime_webapp/providers/Location.dart';
import 'package:realtime_webapp/providers/Locations.dart';
import 'package:realtime_webapp/providers/Timelogs.dart';
import 'package:realtime_webapp/providers/VacationTimelog.dart';
import 'package:realtime_webapp/providers/analytics.dart';
import 'package:realtime_webapp/providers/employee.dart';
import 'package:realtime_webapp/providers/employees.dart';
import 'package:realtime_webapp/providers/employer.dart';
import 'package:realtime_webapp/providers/employers.dart';
import 'package:realtime_webapp/providers/project.dart';
import 'package:realtime_webapp/providers/projects.dart';
import 'package:realtime_webapp/providers/task.dart';
import 'package:realtime_webapp/providers/tasks.dart';

class Services extends ChangeNotifier {
  String _token;

  Services(this._token);

  Future<void> addEmployer(Employer employer) async {
    Uri url = Uri.parse('http://localhost:8080/api/employers/add');
    final response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          'Authorization': 'Bearer $_token',
        },
        body: json.encode(
          {'name': employer.name, 'date': employer.date},
        ));
  }

  Future<void> addLocation(Location location) async {
    Uri url = Uri.parse('http://localhost:8080/api/locations/add');
    print(url);
    print(location.name);
    print(location.lat);
    print(location.lon);
    print(location.radius);
    print(location.employerId);
    final response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          'Authorization': 'Bearer $_token',
        },
        body: json.encode(
          {
            "locationName": location.name,
            "locationLat": location.lat,
            "locationLon": location.lon,
            "radius": location.radius,
            "employerId": location.employerId
          },
        ));
  }

  Future<List<Employers>> getLocations() async {
    Uri url = Uri.parse('http://localhost:8080/api/employers/');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $_token',
    });

    final List<Employers> employers = employersFromJson(response.body);

    return employers;
  }

  Future<List<VacationTimelog>> getVacationTimeSheets(
      String employeeId, String startDate, String endDate) async {
    Uri url = Uri.parse(
        'http://localhost:8080/api/timesheet/vacation?employeeId=$employeeId&startDate=$startDate&endDate=$endDate');
    print(url);
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $_token',
    });

    final List<VacationTimelog> employers =
        vacatinTimelogFromJson(response.body);

    return employers;
  }

  Future<List<Locations>> getLocationsByEmployer(String emloyerId) async {
    Uri url =
        Uri.parse('http://localhost:8080/api/locations/?employerId=$emloyerId');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $_token',
    });

    final List<Locations> locations = locationsFromJson(response.body);
    print("AANTAL LOCATIES : " + locations.length.toString());
    return locations;
  }

  Future<List<Employees>> getEmployees() async {
    Uri url = Uri.parse('http://localhost:8080/api/user/all');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $_token',
    });

    final List<Employees> employees = employeesFromJson(response.body);

    return employees;
  }

  Future<List<Employers>> getEmployers() async {
    Uri url = Uri.parse('http://localhost:8080/api/employers/');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $_token',
    });

    final List<Employers> employers = employersFromJson(response.body);

    return employers;
  }

  Future<List<Projects>> getProjects(String employeeId) async {
    Uri url =
        Uri.parse('http://localhost:8080/api/projects?employeeId=$employeeId');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $_token',
    });

    final List<Projects> projects = projectsFromJson(response.body);

    return projects;
  }

  Future<List<Projects>> getAllProjects() async {
    Uri url = Uri.parse('http://localhost:8080/api/projects');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $_token',
    });

    final List<Projects> projects = projectsFromJson(response.body);

    return projects;
  }

  Future<List<Tasks>> getTaskByProject(String projectId) async {
    Uri url =
        Uri.parse('http://localhost:8080/api/tasks/?projectId=$projectId');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $_token',
    });

    final List<Tasks> tasks = tasksFromJson(response.body);
    print(response.body);
    return tasks;
  }

  Future<void> addEmployee(Employee employee) async {
    Uri url = Uri.parse('http://localhost:8080/auth/signup');
    final response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          'Authorization': 'Bearer $_token',
        },
        body: json.encode(
          {
            "firstName": employee.firstName,
            "lastName": employee.lastName,
            "function": employee.function,
            "active": true,
            "email": employee.email,
            "password": employee.password,
          },
        ));
  }

  Future<void> addProject(Project project) async {
    Uri url = Uri.parse('http://localhost:8080/api/projects/add');
    final response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          'Authorization': 'Bearer $_token',
        },
        body: json.encode(
          {
            "name": project.name,
            "startDate": "${project.startDate}",
            "period": "${project.period}",
            "employerId": project.employer.employerId
          },
        ));
  }

  Future<void> addTask(Task task) async {
    Uri url = Uri.parse('http://localhost:8080/api/tasks/add');
    final response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          'Authorization': 'Bearer $_token',
        },
        body: json.encode(
          {"name": task.name, "projectId": task.projectId},
        ));
    print(response.body);
  }

  Future<List<TotalProject>> getTotalWorkHours(String projectId) async {
    Uri url = Uri.parse(
        'http://localhost:8080/api/timesheet/calculate?projectId=$projectId');

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $_token',
    });

    final List<TotalProject> total = totalProjectFromJson(response.body);

    return total;
  }

  Future<List<AvgTask>> getAvgTask() async {
    Uri url = Uri.parse('http://localhost:8080/api/timesheet/avg');

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $_token',
    });

    final List<AvgTask> total = avgTaskFromJson(response.body);

    return total;
  }

  Future<List<TimelogsForEmployee>> getTimelogsByEmloyee(
      String employeeId, String startDate, String endDate) async {
    Uri url = Uri.parse(
        'http://localhost:8080/api/timesheet/get?employeeId=$employeeId&startDate=$startDate&endDate=$endDate');

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $_token',
    });

    final List<TimelogsForEmployee> total =
        timelogsForEmployeeFromJson(response.body);

    return total;
  }

  Future<List<TotalTimeProjects>> getTotalTimeProjects() async {
    Uri url = Uri.parse('http://localhost:8080/api/timesheet/totalProjects');

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $_token',
    });

    final List<TotalTimeProjects> total =
        totalTimeProjectsFromJson(response.body);

    return total;
  }

  Future<List<AllProjectTime>> getAllTaskHours() async {
    Uri url = Uri.parse('http://localhost:8080/api/timesheet/totalEachTask');

    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $_token',
    });

    final List<AllProjectTime> total = allProjectTimeFromJson(response.body);

    return total;
  }

  Future<void> assignEmployee(String employeeId, String projectId) async {
    print(projectId);
    print(employeeId);
    Uri url = Uri.parse('http://localhost:8080/api/projects/$projectId');
    final response = await http.put(url,
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          'Authorization': 'Bearer $_token',
        },
        body: json.encode(
          {"employeeId": employeeId},
        ));
    print(response.body);
  }
}
