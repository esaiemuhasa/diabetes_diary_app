
import 'package:diabetes_diary_app/model/bean.dart';
import 'package:diabetes_diary_app/model/dao.dart';
import 'package:flutter/material.dart';

class BreadUnitsPage extends StatefulWidget {
  

  const BreadUnitsPage({super.key});

  String getCaption () {
    return "Bread units";
  }

  String getAddingDataButtonCaption () {
    return "New bread";
  }
  @override
  State<BreadUnitsPage> createState() => BreadUnitsPageState();
}

class BreadUnitsPageState extends State<BreadUnitsPage> {

  BreadUnitRepository repository = BreadUnitRepository.getInstance();
  List<BreadUnit> units = [];

  @override
  void initState() {
    super.initState();

    repository.findAll().then((items) {
      setState(() {
        units.addAll(items);
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: units.length,
        itemBuilder: (context, index) {
          return BreadUnitCard(unit: units[index]);
        },
      ),
    );
  }
}

///
class BreadUnitCard extends StatelessWidget {
  final BreadUnit unit;
  const BreadUnitCard({super.key, required this.unit});
  
  void handleClick () {}

  @override
  Widget build(BuildContext context) {
    String date = unit.dayDate ?? "";
    
    return Card(
      child: ListTile(
        title: Text(unit.bread!.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("${unit.serving} portion  "),
                Text("( ${unit.serving * unit.bread!.carbohydratePerServing} Carbohydrate)")
              ],
            ),
            Text(date),
          ],
        ),
        trailing: IconButton(onPressed: () =>
        {
          handleClick()
        }, icon: const Icon(Icons.more_vert)),
      ),
    );
  }
  
}
