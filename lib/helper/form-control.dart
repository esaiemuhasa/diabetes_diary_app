

import 'package:flutter/material.dart';

///simple date-chooser component
class SimpleDateChooser extends StatefulWidget {

  final Function listener;

  const SimpleDateChooser({super.key, required this.listener});

  @override
  State<StatefulWidget> createState() {
    return SimpleDateChooserState(listener);
  }
}

///simple time chooser
class SimpleTimeChooser extends StatefulWidget {
  final Function listener;

  const SimpleTimeChooser ({super.key, required this.listener});
  

  @override
  State<StatefulWidget> createState() {
    return SimpleTimeChooserState(listener);
  }
}

///state manager of date chooser
class SimpleDateChooserState extends State<SimpleDateChooser> {

  DateTime? currentDate;
  TextEditingController currentDateController = TextEditingController(text: "");
  late Function listener;

  SimpleDateChooserState(this.listener);

  @override
  void initState() {
    super.initState();

    DateTime now = DateTime.now();
    currentDate = now;

    currentDateController.value = TextEditingValue(text: "${now.month}/${now.day}/${now.year}");
  }

  void chooseDate (BuildContext context) {
    final DateTime now = DateTime.now();
    Future<DateTime?> date = showDatePicker(
      context: context,
      firstDate: now.subtract(const Duration(days: 7)),
      lastDate: now,
    );

    date.then((selectedDate) {
      final DateTime now = selectedDate ?? currentDate ?? DateTime.now();
      currentDate = now;
      setState(() {
        currentDateController.value = TextEditingValue(text: "${now.month}/${now.day}/${now.year}");
      });
      listener.call(now);
    } );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.5),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: currentDateController,
              readOnly: true,
              onTap: () {
                chooseDate(context);
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Date",
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                chooseDate(context);
              },
              icon: const Icon(Icons.calendar_month_outlined)
          )
        ],
      ),
    );
  }

}


/// State manager of time chooser component
class SimpleTimeChooserState extends State<SimpleTimeChooser> {

  TimeOfDay? currentTime;
  TextEditingController currentTimeController = TextEditingController(text: "");
  late Function listener;

  SimpleTimeChooserState(this.listener);

  @override
  void initState() {
    super.initState();

    TimeOfDay now = TimeOfDay.now();
    currentTime = now;

    currentTimeController.value = TextEditingValue(text: "${now.hour} : ${now.minute}");
  }

  void chooseTime (BuildContext context) {
    Future<TimeOfDay?> date = showTimePicker(context: context, initialTime: TimeOfDay.now());

    date.then((selectedTime) {
      setState(() {
        final TimeOfDay now = selectedTime ?? currentTime ?? TimeOfDay.now();
        currentTime = now;
        currentTimeController.value = TextEditingValue(text: "${now.hour} : ${now.minute}");
      });
    } );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.5),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: currentTimeController,
              readOnly: true,
              onTap: () {
                chooseTime(context);
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Time",
              ),
            ),
          ),
          IconButton(
              onPressed: () {
                chooseTime(context);
              },
              icon: const Icon(Icons.access_time)
          )
        ],
      ),
    );
  }

}