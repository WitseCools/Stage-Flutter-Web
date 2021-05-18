import 'package:flutter/material.dart';
import 'package:realtime_webapp/providers/analytics.dart';
import 'package:provider/provider.dart';

import 'package:realtime_webapp/services/services.dart';
import 'package:realtime_webapp/widgets/loading.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AvgCostGraph extends StatefulWidget {
  AvgCostGraph({Key key}) : super(key: key);

  @override
  _AvgCostGraphState createState() => _AvgCostGraphState();
}

List<AvgTask> data = [];

class _AvgCostGraphState extends State<AvgCostGraph> {
  @override
  void initState() {
    super.initState();
    setData();
  }

  void setData() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Services service = Provider.of<Services>(context, listen: false);
      service.getAvgTask().then((value) {
        setState(() {
          data = value;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Services services = Provider.of<Services>(context);
    return FutureBuilder(
      future: services.getAllTaskHours(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return Loading();
        } else
          return Container(
              child: SfCircularChart(
                  legend: Legend(isVisible: true),
                  series: <CircularSeries>[
                PieSeries<AvgTask, String>(
                  dataSource: data,
                  xValueMapper: (AvgTask proj, _) => proj.name,
                  yValueMapper: (AvgTask proj, _) => proj.average.round(),
                  dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                  ),
                )
              ]));
      },
    );
  }
}
