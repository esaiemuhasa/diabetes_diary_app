
import 'package:diabetes_diary_app/helper/form-control.dart';
import 'package:diabetes_diary_app/model/bean.dart';
import 'package:diabetes_diary_app/model/dao.dart';
import 'package:flutter/material.dart';

class GlucoseFormPage extends StatelessWidget {

  const GlucoseFormPage({super.key});

  @override
  Widget build(BuildContext context) {

    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.shadowColor,
        title: const Text("Insert glucose"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: FormContainer()
      )
    );
  }
}


class FormContainer extends StatefulWidget {
  
  const FormContainer({super.key});

  @override
  State<FormContainer> createState() => FormContainerState();
}

class FormContainerState extends State<FormContainer> {

  GlucoseRepository repository = GlucoseRepository.getInstance();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String takenValue = "";

  void handlePersist (BuildContext context) {
    Glucose data = Glucose(
      takenValue: double.parse(takenValue),
      dayDate: "${selectedDate.month}/${selectedDate.day}/${selectedDate.year} at ${selectedTime.hour}:${selectedTime.minute}"
    );

    repository.create(data).then((data) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 0
          ),
          child: TextField(
            onChanged: (value) {
              setState(() {
                takenValue = value;
              });
            },
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter value in mmoll/dl"
            ),
          ),
        ),

        Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 0
            ),
            child: SimpleDateChooser(listener: (DateTime date) {
              setState(() {
                selectedDate = date;
              });
            })
        ),

        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 0
          ),
          child: SimpleTimeChooser(listener: (TimeOfDay time) {
            setState(() {
              selectedTime = time;
            });
          })
        ),

        Padding(
          padding: const EdgeInsets.symmetric( vertical: 10, horizontal: 0),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: takenValue.isEmpty ? null : () {
                    handlePersist(context);
                  },
                  child: const Text("Save")
                ),
              ),
            ],
          )
        )
      ],
    );
  }
}