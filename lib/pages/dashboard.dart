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
              "Glucose chart",
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

  @override
  void initState() {
    super.initState();

    repository.findAll().then((items) => {
      setState(() {
        for(var i = items.length-1; i>=0 ; i -= 1) {
          Glucose cl = items[i];
          double x = items.length - 1.0 - i;
          print("X = ${x}");
          var item = FlSpot(x, cl.takenValue);
          dataList.add(item);
        }
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
          minX: 0,
          maxX: 20,
          minY: 0,
          maxY: 11,
        )
    );
  }

  FlGridData gridData() => FlGridData(
    show: true,
    drawVerticalLine: true,
    horizontalInterval: 1.5,
    verticalInterval: 1.5,
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
    interval: 2,
    reservedSize: 35,
    showTitles: true,
  );

  SideTitleWidget bottomTitleWidgets(double value, TitleMeta meta) {
    String text = switch (value.toInt()) {
      0 => '',
      1 => '',
      2 => '',
      3 => '',
      4 => '',
      5 => '',
      6 => '',
      7 => '',
      8 => '',
      9 => '',
      10 => '',
      11 => '',
      12 => '',
      _ => '',
    };

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }

  SideTitles leftTitles() => SideTitles(
    getTitlesWidget: leftTitleWidgets,
    interval: 1,
    reservedSize: 40,
    showTitles: true,
  );

  Text leftTitleWidgets(double value, TitleMeta meta) {
    String text = switch (value.toInt()) {
      1 => '50',
      2 => '100',
      3 => '150',
      4 => '200',
      5 => '250',
      6 => '300',
      7 => '350',
      8 => '400',
      9 => '450',
      10 => '500',
      _ => '',
    };

    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
          fontWeight: FontWeight.bold, fontSize: 14, color: Colors.white),
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


  LineChartBarData lineChartBarDataCurrentWeek() => LineChartBarData(
    isCurved: true,
    curveSmoothness: 0,
    color: const Color(0xFF50E4FF),
    barWidth: 2,
    isStrokeCapRound: true,
    dotData: const FlDotData(show: true),
    belowBarData: BarAreaData(show: false),

    spots: dataList,
  );
}