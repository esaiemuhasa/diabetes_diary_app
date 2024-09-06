import 'package:flutter/material.dart';

class GlucosePage extends StatelessWidget {

  const GlucosePage({super.key});

  String getTitle () {
    return "Glucose";
  }

  void handleClick (int index) {
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return Card(
            child:  ListTile(
              leading: const Icon(Icons.bloodtype_sharp),
              title: Text('$index mmol/dl'),
              subtitle: const Text("10/04/2024 a 12h 20"),
              trailing: IconButton(onPressed: () => {
                handleClick(index)
              }, icon: const Icon(Icons.more_vert)),
            ),
          );
        },
      ),
    );
  }
}
