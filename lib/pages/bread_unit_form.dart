
import 'package:flutter/material.dart';

class BreadUnitFormPage extends StatelessWidget {

  const BreadUnitFormPage({super.key});

  @override
  Widget build(BuildContext context) {

    ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.shadowColor,
        title: const Text("New bread"),
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
          child: Row(
            children: [
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Portion"
                  ),
                ),
              ),
              DropdownMenu<String>(
                initialSelection: dropdownValue,
                onSelected: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(
                      value: value,
                      label: value
                  );
                }).toList(),
              )
            ],
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
                  enabled: false,
                  hintText: ""
              ),
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
