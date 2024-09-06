import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {

  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return const Card(
      shadowColor: Colors.transparent,
      margin: EdgeInsets.all(8.0),
      child: SizedBox.expand(
        child: Center(
        ),
      ),
    );
  }

}
