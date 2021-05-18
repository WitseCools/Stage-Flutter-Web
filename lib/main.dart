import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_webapp/providers/Location.dart';

import 'package:realtime_webapp/providers/User.dart';
import 'package:realtime_webapp/providers/currentEmployeeStatics.dart';
import 'package:realtime_webapp/providers/employee.dart';
import 'package:realtime_webapp/providers/employer.dart';
import 'package:realtime_webapp/providers/project.dart';
import 'package:realtime_webapp/providers/projects.dart';
import 'package:realtime_webapp/providers/task.dart';
import 'package:realtime_webapp/screens/addEmployee.dart';
import 'package:realtime_webapp/screens/addEmployer.dart';
import 'package:realtime_webapp/screens/addLocationScreen.dart';
import 'package:realtime_webapp/screens/addProjectScreen.dart';
import 'package:realtime_webapp/screens/login.dart';
import 'package:realtime_webapp/screens/navigation.dart';
import 'package:realtime_webapp/screens/projectListScreen.dart';
import 'package:realtime_webapp/screens/statisticsScreen.dart';
import 'package:realtime_webapp/services/services.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => User()),
        ChangeNotifierProvider(create: (context) => Employer()),
        ChangeNotifierProvider(create: (context) => Location()),
        ChangeNotifierProvider(create: (context) => Employee()),
        ChangeNotifierProvider(create: (context) => Project()),
        ChangeNotifierProvider(create: (context) => Task()),
        ChangeNotifierProvider(
            create: (context) => CurrentEmployeeStatistics()),
        ChangeNotifierProxyProvider<User, Services>(
          update: (context, user, previous) => Services(user.token),
        )
        /*
        ChangeNotifierProvider(create: (context) => Project()),
        ChangeNotifierProvider(create: (context) => Projects()),
        ChangeNotifierProvider(create: (context) => Employer()),
        ChangeNotifierProvider(create: (context) => Locations()),
        ChangeNotifierProvider(create: (contect) => Tasks()),
        ChangeNotifierProvider(create: (context) => TimeSheet()),
        ChangeNotifierProvider(create: (context) => AutomaticDate()),
        ChangeNotifierProvider(create: (context) => AutomaticDateList()),
        ChangeNotifierProxyProvider4<TimeSheet, User, Project, Project,
            Services>(
          update: (context, timesheet, user, project, projects, prev) =>
              Services(timesheet.date, user.userId, user.token,
                  project.projectId, project.employerId),
        ),*/
      ],
      child: Consumer<User>(
        builder: (context, authData, _) => MaterialApp(
          builder: (context, widget) => ResponsiveWrapper.builder(
              BouncingScrollWrapper.builder(context, widget),
              maxWidth: 1920,
              minWidth: 1080,
              defaultScale: false,
              breakpoints: [
                ResponsiveBreakpoint.resize(450, name: MOBILE),
                ResponsiveBreakpoint.autoScale(800, name: TABLET),
                ResponsiveBreakpoint.autoScale(1000, name: TABLET),
                ResponsiveBreakpoint.resize(1200, name: DESKTOP),
                ResponsiveBreakpoint.autoScale(2460, name: "4K"),
              ],
              background: Container(color: Color(0xFFF5F5F5))),
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: authData.isAuth ? Navigation() : LogInScreen(),
          routes: {
            /*AddTimeSheet_Screen.routeName: (ctx) => AddTimeSheet_Screen(),
            VacationScreen.routeName: (ctx) => VacationScreen(),*/
            AddEmployerScreen.routeName: (ctx) => AddEmployerScreen(),
            AddLocationScreen.routeName: (ctx) => AddLocationScreen(),
            AddEmployeeScreen.routeName: (ctx) => AddEmployeeScreen(),
            AddProjectScreen.routeName: (ctx) => AddProjectScreen(),
            StatisticsScreen.routeName: (ctx) => StatisticsScreen()
          },
        ),
      ),
    );
  }
}
