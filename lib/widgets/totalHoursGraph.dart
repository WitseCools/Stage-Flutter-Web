import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realtime_webapp/providers/analytics.dart';
import 'package:realtime_webapp/services/services.dart';
import 'package:realtime_webapp/widgets/loading.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TotalHoursGraph extends StatefulWidget {
  TotalHoursGraph({Key key}) : super(key: key);

  @override
  _TotalHoursGraphState createState() => _TotalHoursGraphState();
}

List<AllProjectTime> data = [];

class _TotalHoursGraphState extends State<TotalHoursGraph> {
  @override
  void initState() {
    super.initState();
    setData();
  }

  void setData() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Services service = Provider.of<Services>(context, listen: false);
      service.getAllTaskHours().then((value) {
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
              child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  enableSideBySideSeriesPlacement: false,
                  series: <ChartSeries>[
                ColumnSeries<AllProjectTime, String>(
                  dataSource: data,
                  xValueMapper: (AllProjectTime proj, _) => proj.name,
                  yValueMapper: (AllProjectTime proj, _) => proj.totaal,
                  dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                  ),
                ),
              ]));
      },
    );
  }
}
