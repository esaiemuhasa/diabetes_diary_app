import 'package:diabetes_diary_app/model/bean.dart';
import 'package:diabetes_diary_app/model/dao.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {

  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {

    return const Card(
      shadowColor: Colors.transparent,
      margin: EdgeInsets.all(0),
      child: SizedBox.expand(
        child: Center(
          child: LineChartWidget()
        ),
      ),
    );
  }

}

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.shade50,
      child: const Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Blood sugar chart",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 2
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 25, left: 2.5, bottom: 10),
              child: LineChartContainer(),
            ),
          )
        ],
      ),
    );
  }
}

class LineChartContainer extends StatefulWidget {

  const LineChartContainer({super.key});

  @override
  State<LineChartContainer> createState() => _LineChartContainerState();
}

class _LineChartContainerState extends State<LineChartContainer> {

  GlucoseRepository repository = GlucoseRepository.getInstance();
  List<FlSpot> dataList = [];
  double maxX = 1;
  double maxY = 1;
  double minX = 0;
  double minY = 0;

  @override
  void initState() {
    super.initState();

    repository.findAll().then((items) => {
      setState(() {
        List<FlSpot> spots = [];
        minY = items[0].takenValue;
        for(var i = items.length-1; i>=0 ; i -= 1) {
          Glucose cl = items[i];
          double x = items.length - 1.0 - i;

          if (cl.takenValue > maxY) {
            maxY = cl.takenValue;
          }

          if (cl.takenValue < minY) {
            minY = cl.takenValue;
          }

          var item = FlSpot(x, cl.takenValue);
          spots.add(item);
        }

        maxX = items.length + 0.0;
        maxY += 5;

        dataList.addAll(spots);
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
        LineChartData(
          lineTouchData: const LineTouchData(
            handleBuiltInTouches: true,
          ),
          gridData: gridData(),
          titlesData: titlesData(),
          borderData: borderData(),
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              curveSmoothness: 0,
              color: const Color(0xFF50E4FF),
              barWidth: 2,
              isStrokeCapRound: true,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(show: false),
              spots: dataList,
            )
          ],
          minX: minX,
          maxX: maxX,
          minY: minY,
          maxY: maxY,
        )
    );
  }

  FlGridData gridData() => FlGridData(
    show: true,
    drawVerticalLine: true,
    horizontalInterval: maxY > 25 ? 25 : 1,
    verticalInterval: 1,
    getDrawingHorizontalLine: (double _) => FlLine(
      color: Colors.blue.withOpacity(0.15),
      strokeWidth: 1,
    ),
    getDrawingVerticalLine: (double _) => FlLine(
      color: Colors.blue.withOpacity(0.15),
      strokeWidth: 1,
    ),
  );

  FlTitlesData titlesData() => FlTitlesData(
    bottomTitles: AxisTitles(
      sideTitles: bottomTitles(),
    ),
    rightTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    leftTitles: AxisTitles(
      sideTitles: leftTitles(),
    ),
  );

  SideTitles bottomTitles() => SideTitles(
    getTitlesWidget: bottomTitleWidgets,
    interval: maxX / 10.0,
    reservedSize: 35,
    showTitles: false,
  );

  SideTitleWidget bottomTitleWidgets(double value, TitleMeta meta) {
    String text = switch (value) {
      0 => '0',
      1 => '1',
      2 => '2',
      3 => '3',
      4 => '4',
      5 => '5',
      6 => '6',
      7 => '7',
      8 => '8',
      9 => '9',
      10 => '10',
      11 => '11',
      12 => '12',
      13 => '13',
      14 => '14',
      _ => "$value",
    };

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
          color: Colors.black26,
        ),
      ),
    );
  }

  SideTitles leftTitles() => SideTitles(
    getTitlesWidget: leftTitleWidgets,
    interval: maxY / 10,
    reservedSize: 40,
    showTitles: true,
  );

  Text leftTitleWidgets(double value, TitleMeta meta) {
    String text = switch (value) {
      50 => '50',
      100 => '100',
      150 => '150',
      200 => '200',
      250 => '250',
      300 => '300',
      350 => '350',
      400 => '400',
      450 => '450',
      500 => '500',
      _ => '$value',
    };

    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black26),
    );
  }

  FlBorderData borderData() => FlBorderData(
    show: true,
    border: Border(
      bottom: BorderSide(
        color: const Color(0xFF50E4FF).withOpacity(0.2),
        width: 4,
      ),
      left: const BorderSide(color: Colors.transparent),
      right: const BorderSide(color: Colors.transparent),
      top: const BorderSide(color: Colors.transparent),
    ),
  );


}