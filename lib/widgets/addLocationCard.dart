import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:realtime_webapp/providers/Location.dart';
import 'package:realtime_webapp/services/services.dart';
import 'package:realtime_webapp/widgets/LocationListCard.dart';
import 'package:provider/provider.dart';

class AddLocationCard extends StatefulWidget {
  String employerId;
  String employerName;
  AddLocationCard({Key key, this.employerId, this.employerName})
      : super(key: key);

  @override
  _AddLocationCardState createState() => _AddLocationCardState();
}

class _AddLocationCardState extends State<AddLocationCard> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _latController = TextEditingController();
  final _longController = TextEditingController();
  final _radiusController = TextEditingController();

  void _submit() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Services service = Provider.of<Services>(context, listen: false);
      Location location = Provider.of<Location>(context, listen: false);
      location.employerId = widget.employerId;
      service.addLocation(location);
    });
  }

  @override
  Widget build(BuildContext context) {
    Location location = Provider.of<Location>(context, listen: false);

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
                          "Add Location",
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Employer: " + widget.employerName,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              Container(
                                width: 500,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: _nameController,
                                    onSaved: (newValue) {
                                      location.name = newValue;
                                    },
                                    decoration: InputDecoration(
                                        labelText: "Name Location",
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                              ),
                              Container(
                                width: 500,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: _latController,
                                    onSaved: (newValue) {
                                      location.lat = double.parse(newValue);
                                    },
                                    decoration: InputDecoration(
                                        labelText: "Latitude",
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                              ),
                              Container(
                                width: 500,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: _longController,
                                    onSaved: (newValue) {
                                      location.lon = double.parse(newValue);
                                    },
                                    decoration: InputDecoration(
                                        labelText: "longitude",
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                              ),
                              Container(
                                width: 500,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: _radiusController,
                                    onSaved: (newValue) {
                                      location.radius = int.parse(newValue);
                                    },
                                    decoration: InputDecoration(
                                        labelText: "Radius",
                                        border: OutlineInputBorder()),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: RaisedButton(
                                  onPressed: () {
                                    _submit();
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
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Location list",
                          style: TextStyle(
                              color: HexColor("#222C4A"),
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      LocationListCard(
                        employerId: widget.employerId,
                      )
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
