import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_webapp/providers/analytics.dart';
import 'package:realtime_webapp/services/services.dart';
import 'package:realtime_webapp/widgets/loading.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TotalTimeProjectsGraph extends StatefulWidget {
  TotalTimeProjectsGraph({Key key}) : super(key: key);

  @override
  _TotalTimeProjectsGraphState createState() => _TotalTimeProjectsGraphState();
}

List<TotalTimeProjects> data = [];

class _TotalTimeProjectsGraphState extends State<TotalTimeProjectsGraph> {
  @override
  void initState() {
    super.initState();
    setData();
  }

  void setData() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Services service = Provider.of<Services>(context, listen: false);
      service.getTotalTimeProjects().then((value) {
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
                PieSeries<TotalTimeProjects, String>(
                  dataSource: data,
                  xValueMapper: (TotalTimeProjects proj, _) => proj.projectName,
                  yValueMapper: (TotalTimeProjects proj, _) => proj.totaal,
                  dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                  ),
                )
              ]));
      },
    );
  }
}
