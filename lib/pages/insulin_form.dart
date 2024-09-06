
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

  List<String> list = <String>['One', 'Two', 'Three', 'Four'];
  String? dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = list.first;
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
          child: DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.keyboard_arrow_down),
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            underline: Container(
              height: 1.0,
              color: Colors.black45,
            ),
            onChanged: (String? value) {
              // This is called when the user selects an item.
              setState(() {
                dropdownValue = value!;
              });
            },
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          )
        ),

        const Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 0
          ),
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Quantity (in IU)"
            ),
          ),
        ),

        const Padding(
            padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 0
            ),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Date"
                      ),
                    )
                ),
                IconButton(onPressed: null, icon: Icon(Icons.calendar_month_outlined))
              ],
            )
        ),

        const Padding(
          padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 0
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Time"
                  ),
                )
              ),
              IconButton(onPressed: null, icon: Icon(Icons.access_time_rounded))
            ],
          )
        ),

        const Padding(
          padding: EdgeInsets.symmetric( vertical: 10, horizontal: 0),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(onPressed: null, child: Text("Save")),
              ),
            ],
          )
        )
      ],
    );
  }
}
