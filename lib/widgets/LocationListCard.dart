import 'package:flutter/material.dart';
import 'package:realtime_webapp/providers/Locations.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:realtime_webapp/services/services.dart';
import 'package:provider/provider.dart';
import 'package:realtime_webapp/widgets/loading.dart';

class LocationListCard extends StatefulWidget {
  String employerId;
  LocationListCard({this.employerId, Key key}) : super(key: key);

  @override
  _LocationListCardState createState() => _LocationListCardState();
}

List<Locations> _locations = [];

class _LocationListCardState extends State<LocationListCard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Services service = Provider.of<Services>(context, listen: false);
      service.getLocationsByEmployer(widget.employerId).then((value) {
        _locations = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Services service = Provider.of<Services>(context, listen: false);
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            width: 600,
            height: 400,
            child: Container(
                child: FutureBuilder(
              future: service.getLocationsByEmployer(widget.employerId),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Loading();
                } else
                  return ListView.builder(
                    shrinkWrap: true,
                    reverse: true,
                    primary: false,
                    itemCount: _locations.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 5,
                            child: ListTile(
                              title: Text('${_locations[index].toString()}'),
                            ),
                          ));
                    },
                  );
              },
            )),
          ),
        ));
  }
}
