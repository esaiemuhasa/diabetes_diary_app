import 'package:diabetes_diary_app/pages/glucose_form.dart';
import 'package:diabetes_diary_app/pages/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainAppContainer());
}

///Main container of our app
class MainAppContainer extends StatelessWidget {
  const MainAppContainer({super.key});

  @override
  Widget build(BuildContext context) {
    const String title = "Diabetes diary";
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const HomePageContainer(),
    );
  }
}
