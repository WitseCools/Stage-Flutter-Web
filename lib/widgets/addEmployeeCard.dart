import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:realtime_webapp/providers/employee.dart';
import 'package:realtime_webapp/services/services.dart';
import 'package:provider/provider.dart';

class AddEmployeeCard extends StatefulWidget {
  AddEmployeeCard({Key key}) : super(key: key);

  @override
  _AddEmployeeCardState createState() => _AddEmployeeCardState();
}

class _AddEmployeeCardState extends State<AddEmployeeCard> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _functionController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _submit() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Services service = Provider.of<Services>(context, listen: false);
      Employee employee = Provider.of<Employee>(context, listen: false);
      service.addEmployee(employee);
    });
  }

  String dropdownValue = 'Consultant';

  @override
  Widget build(BuildContext context) {
    Services service = Provider.of<Services>(context, listen: false);
    Employee employee = Provider.of<Employee>(context, listen: false);
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Container(
          width: 1200,
          decoration: BoxDecoration(
            border: Border.all(
              width: 15,
              color: HexColor("#222C4A"),
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: SingleChildScrollView(
            child: Card(
              elevation: 2,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Add employee",
                          style: TextStyle(
                              color: HexColor("#222C4A"),
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 500,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: _firstNameController,
                                    onSaved: (newValue) {
                                      employee.firstName = newValue;
                                    },
                                    decoration: InputDecoration(
                                        labelText: "Firstname",
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                              ),
                              Container(
                                width: 500,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: _lastNameController,
                                    onSaved: (newValue) {
                                      employee.lastName = newValue;
                                    },
                                    decoration: InputDecoration(
                                        labelText: "Lastname",
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                              ),
                              Container(
                                width: 500,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: _functionController,
                                    onSaved: (newValue) {
                                      employee.function = newValue;
                                    },
                                    decoration: InputDecoration(
                                        labelText: "Function",
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                              ),
                              Container(
                                width: 500,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: _emailController,
                                    onSaved: (newValue) {
                                      employee.email = newValue;
                                    },
                                    decoration: InputDecoration(
                                        labelText: "Email",
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                              ),
                              Container(
                                width: 500,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: _passwordController,
                                    onSaved: (newValue) {
                                      employee.password = newValue;
                                    },
                                    decoration: InputDecoration(
                                        labelText: "Password",
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                              ),
                              Container(
                                  width: 500,
                                  child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: DropdownButton<String>(
                                        value: dropdownValue,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            dropdownValue = newValue;
                                            employee.employeeType =
                                                dropdownValue;
                                          });
                                        },
                                        items: <String>[
                                          'Consultant',
                                          'Manager',
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ))),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                  onPressed: () {
                                    _submit();
                                    service.notifyListeners();
                                  },
                                  color: HexColor("#222C4A"),
                                  child: Text(
                                    "Save",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
