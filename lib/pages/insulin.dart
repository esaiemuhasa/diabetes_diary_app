
import 'package:diabetes_diary_app/model/bean.dart';
import 'package:diabetes_diary_app/model/dao.dart';
import 'package:flutter/material.dart';

class InsulinPage extends StatefulWidget {


  const InsulinPage({super.key});

  String getCaption () {
    return "Insulin";
  }

  String getAddingDataButtonCaption () {
    return "New insulin";
  }

  @override
  State<InsulinPage> createState() => InsulinPageState();
}

class InsulinPageState extends State<InsulinPage> {
  InsulinRepository repository = InsulinRepository.getInstance();
  List<Insulin> list = <Insulin>[];

  @override
  void initState() {
    super.initState();
    repository.findAll()
    .then((items) {
      setState(() {
        list.addAll(items);
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return ItemCard(insulin: list[index]);
        },
      ),
    );
  }
}


class ItemCard extends StatelessWidget {

  final Insulin insulin;

  const ItemCard({super.key, required this.insulin});

  void handleClick () {

  }

  @override
  Widget build(BuildContext context) {
    String? date = insulin.dayDate;
    date ??= "";
    return Card(
      child: ListTile(
        title: Text("${insulin.injectedQuantity} IU,  ${insulin.type!.name}"),
        subtitle: Text(date),
        trailing: IconButton(onPressed: () =>
        {
          handleClick()
        }, icon: const Icon(Icons.more_vert)),
      ),
    );
  }

}