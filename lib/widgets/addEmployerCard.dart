import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:realtime_webapp/providers/employer.dart';
import 'package:realtime_webapp/services/services.dart';
import 'package:realtime_webapp/widgets/addLocationCard.dart';
import 'package:realtime_webapp/widgets/employerListCard.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:provider/provider.dart';

class AddEmployerCard extends StatefulWidget {
  AddEmployerCard({Key key}) : super(key: key);

  @override
  _AddEmployerState createState() => _AddEmployerState();
}

class _AddEmployerState extends State<AddEmployerCard> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  void _submit() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Services service = Provider.of<Services>(context, listen: false);
      Employer employer = Provider.of<Employer>(context, listen: false);
      service.addEmployer(employer);
    });
  }

  @override
  Widget build(BuildContext context) {
    Employer employer = Provider.of<Employer>(context, listen: false);
    Services service = Provider.of<Services>(context, listen: true);
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 15,
              color: HexColor("#222C4A"),
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          width: 700,
          height: 520,
          child: SingleChildScrollView(
            child: Card(
              elevation: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Add Employer",
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
                                controller: _nameController,
                                onSaved: (newValue) {
                                  employer.name = newValue;
                                },
                                decoration: InputDecoration(
                                    labelText: "Name employer",
                                    border: OutlineInputBorder()),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Date",
                                  style: TextStyle(
                                      color: HexColor("#222C4A"),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                Container(
                                  width: 500,
                                  child: SfDateRangePicker(
                                    onSelectionChanged:
                                        (dateRangePickerSelectionChangedArgs) {
                                      employer.date = DateFormat('yyyy-MM-dd')
                                          .format(
                                              dateRangePickerSelectionChangedArgs
                                                  .value);
                                    },
                                    backgroundColor: Colors.grey[200],
                                    selectionColor: HexColor("#222C4A"),
                                    todayHighlightColor: HexColor("#222C4A"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              onPressed: () {
                                _submit();
                                service.notifyListeners();
                                Navigator.of(context).pop();
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
            ),
          ),
        ),
      ),
    );
  }
}
