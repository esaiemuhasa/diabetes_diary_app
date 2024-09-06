
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


class FormContainer extends StatelessWidget {

  const FormContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 0
          ),
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter value in mmoll/dl"
            ),
          ),
        ),

        Padding(
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

        Padding(
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

        Padding(
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