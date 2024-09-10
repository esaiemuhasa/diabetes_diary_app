import 'package:diabetes_diary_app/model/bean.dart';
import 'package:diabetes_diary_app/model/dao.dart';
import 'package:flutter/material.dart';

class GlucosePage extends StatefulWidget {
  
  const GlucosePage({super.key});

  String getTitle () {
    return "Glucose";
  }

  String getCaption () {
    return "Glucose";
  }

  String getAddingDataButtonCaption () {
    return "New glucose";
  }

  @override
  State<GlucosePage> createState() => GlucosePageState();
}

class GlucosePageState extends State<GlucosePage> {

  GlucoseRepository repository = GlucoseRepository.getInstance();
  List<Glucose> list = [];

  @override
  void initState() {
    super.initState();

    repository.findAll().then((items) {
      setState(() {
        list.addAll(items);
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return GlucoseItemCard(glucose: list[index]);
        },
      ),
    );
  }
}

class GlucoseItemCard extends StatelessWidget {
  final Glucose glucose;

  const GlucoseItemCard({super.key, required this.glucose});

  void handleClick () {

  }

  @override
  Widget build(BuildContext context) {
    String date = glucose.dayDate ?? "";

    return Card(
      child:  ListTile(
        leading: const Icon(Icons.bloodtype_sharp),
        title: Text('${glucose.takenValue} mmol/dl'),
        subtitle: Text(date),
        trailing: IconButton(onPressed: () => {
          handleClick()
        }, icon: const Icon(Icons.more_vert)),
      ),
    );
  }

}
