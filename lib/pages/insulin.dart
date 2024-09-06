
import 'package:flutter/material.dart';

class InsulinPage extends StatelessWidget {

  const InsulinPage({super.key});

  void handleClick (int index) {

  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text('Insulin $index'),
              subtitle: const Text("10/04/2024 a 12h 20"),
              trailing: IconButton(onPressed: () =>
              {
                handleClick(index)
              }, icon: const Icon(Icons.more_vert)),
            ),
          );
        },
      ),
    );
  }

}