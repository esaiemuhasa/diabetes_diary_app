
import 'dart:async';
import 'package:diabetes_diary_app/helper/form-control.dart';
import 'package:diabetes_diary_app/model/bean.dart';
import 'package:diabetes_diary_app/model/dao.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class InsulinFormPage extends StatelessWidget {

  const InsulinFormPage({super.key});

  @override
  Widget build(BuildContext context) {

    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.shadowColor,
        title: const Text("Insert insulin"),
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
  State<StatefulWidget> createState() {
    return FormContainerState();
  }

}


class FormContainerState extends State<FormContainer> {

  final InsulinTypeRepository typeRepository = InsulinTypeRepository.getInstance();
  final InsulinRepository repository = InsulinRepository.getInstance();
  List<InsulinType> list = <InsulinType>[];

  InsulinType? dropdownValue;
  DateTime? currentDate;
  TimeOfDay? currentTime;
  String tapedQuantity = "";

  @override
  void initState() {
    super.initState();
    Future<List<InsulinType>> data = typeRepository.findAll();
    data.then((items) {
      setState(() {
        list.clear();
        list.addAll(items);
        dropdownValue = list.first;
      });
    }).catchError((error) {
      if (kDebugMode) {
        print("Error occurred in loading data process ${error.toString()}");
      }
    });

    DateTime now = DateTime.now();
    currentTime = TimeOfDay(hour: now.hour, minute: now.minute);
    currentDate = now;
  }

  /// Save data in database
  void handlePersist (BuildContext context) {
    Insulin insulin = Insulin(
      injectedQuantity: double.parse(tapedQuantity),
      type: dropdownValue,
      dayDate: "${currentDate!.month}/${currentDate!.day}/${currentDate!.year} at ${currentTime!.hour}:${currentTime!.minute}"
    );

    repository.create(insulin).then((data) {
      Navigator.pop(context);
    }).catchError((error) {
      if (kDebugMode) {
        print("Error ${error.toString()}");
      }
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
          child: DropdownMenu<InsulinType>(
            initialSelection: dropdownValue,
            expandedInsets: EdgeInsets.zero,
            onSelected: (InsulinType? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value;
              });
            },
            dropdownMenuEntries: list.map<DropdownMenuEntry<InsulinType>>((InsulinType value) {
              return DropdownMenuEntry<InsulinType>(
                  value: value,
                  label: value.toString()
              );
            }).toList(),
          )
        ),

        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 0
          ),
          child: TextField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Quantity (in IU)",
            ),
            onChanged: (value) {
              setState(() {
                tapedQuantity = value;
              });
            },
          )
        ),

        Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 0
            ),
            child: SimpleDateChooser(listener: (DateTime date) {
              setState(() {
                currentDate = date;
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
              currentTime = time;
            });
          })
        ),

        Padding(
          padding: const EdgeInsets.symmetric( vertical: 10, horizontal: 0),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: tapedQuantity.trim().isEmpty ? null : () {
                    handlePersist(context);
                  },
                  child: const Text("Save"),
                ),
              ),
            ],
          )
        )
      ],
    );
  }
}
