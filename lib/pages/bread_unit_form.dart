
import 'package:diabetes_diary_app/helper/form-control.dart';
import 'package:diabetes_diary_app/model/bean.dart';
import 'package:diabetes_diary_app/model/dao.dart';
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

  BreadConfigRepository configRepository = BreadConfigRepository.getInstance();
  BreadUnitRepository repository = BreadUnitRepository.getInstance();

  List<BreadConfig> list = <BreadConfig>[];
  BreadConfig? selectedBread;
  String portionValue = "";
  DateTime currentDate = DateTime.now();
  TimeOfDay currentTime = TimeOfDay.now();
  String calculatedCarbohydrate = "";
  TextEditingController calculatedCarbohydrateController = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    configRepository.findAll().then((items) {
      setState(() {
        list.addAll(items);
        selectedBread = list.first;
      });
    });
  }

  void revalidateCalculated () {
    BreadConfig? config = selectedBread;
    if (config == null || portionValue.isEmpty) {
      calculatedCarbohydrateController.value = const TextEditingValue(text: "");
      return;
    }

    double value = double.parse(portionValue) * config.carbohydratePerServing;
    calculatedCarbohydrateController.value = TextEditingValue(text: value.toString());
  }

  void handlePersist (BuildContext context) {
    BreadUnit unit = BreadUnit(
      serving: double.parse(portionValue),
      bread: selectedBread,
      dayDate: "${currentDate.month}/${currentDate.day}/${currentDate.year} at ${currentTime.hour}:${currentTime.minute}"
    );

    print("Bread config ${selectedBread!.name} ==== ${selectedBread!.id}");

    repository.create(unit).then((data) {
      Navigator.pop(context);
    }).catchError((error) {
      print("Error : ${error.toString()}");
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
            child: DropdownMenu<BreadConfig>(
              initialSelection: selectedBread,
              expandedInsets: EdgeInsets.zero,
              onSelected: (BreadConfig? value) {
                setState(() {
                  selectedBread = value;
                  revalidateCalculated();
                });
              },
              dropdownMenuEntries: list.map<DropdownMenuEntry<BreadConfig>>((BreadConfig value) {
                return DropdownMenuEntry<BreadConfig>(
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
                  hintText: "Portion"
              ),
              onChanged: (value) {
                setState(() {
                  portionValue = value;
                  revalidateCalculated();
                });
              },
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
                  enabled: false,
                  hintText: ""
              ),
              controller: calculatedCarbohydrateController,
            )
        ),

        Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 0
            ),
            child: SimpleDateChooser(listener: (DateTime date) {})
        ),

        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 0
          ),
          child: SimpleTimeChooser(listener: (TimeOfDay time) {})
        ),

        Padding(
          padding: const EdgeInsets.symmetric( vertical: 10, horizontal: 0),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(onPressed: portionValue.isEmpty ? null : () => {
                  handlePersist(context)
                }, child: const Text("Save")),
              ),
            ],
          )
        )
      ],
    );
  }
}
