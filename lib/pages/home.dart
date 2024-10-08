import 'package:diabetes_diary_app/pages/bread_unit_form.dart';
import 'package:diabetes_diary_app/pages/glucose_form.dart';
import 'package:diabetes_diary_app/pages/insulin.dart';
import 'package:diabetes_diary_app/pages/insulin_form.dart';
import 'package:flutter/material.dart';
import 'package:uicons/uicons.dart';
import 'package:diabetes_diary_app/pages/bread_units.dart';
import 'package:diabetes_diary_app/pages/dashboard.dart';
import 'package:diabetes_diary_app/pages/glucose.dart';

/// Home page widget.
/// At top we have shortcuts of all functionality.
/// And after we have last operations realized by user
class HomePageContainer extends StatefulWidget {
  const HomePageContainer({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomePageContainerState();
  }
}

class HomePageContainerState extends State<HomePageContainer> {
  int currentView = 0;

  GlucosePage glucosePage = const GlucosePage();
  InsulinPage insulinPage = const InsulinPage();
  BreadUnitsPage breadUnitsPage = const BreadUnitsPage();

  String getTitle () {
    switch (currentView) {
      case 0:
        return "Dashboard";
      case 1:
        return glucosePage.getCaption();
      case 2:
        return breadUnitsPage.getCaption();
      case 3:
        return insulinPage.getCaption();
    }
    return "";
  }

  String getButtonCaption () {
    switch (currentView) {
      case 1:
        return glucosePage.getAddingDataButtonCaption();
      case 2:
        return breadUnitsPage.getAddingDataButtonCaption();
      case 3:
        return insulinPage.getAddingDataButtonCaption();
    }
    return "";
  }

  void requireInsert (BuildContext context) {
    switch(currentView) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const GlucoseFormPage())
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BreadUnitFormPage())
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  const InsulinFormPage())
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.shadowColor,
        title: Row(
          children: [
            Expanded(child: Text(getTitle())),
            currentView == 0 ? const Text("") : ElevatedButton(
                onPressed: () => {
                  requireInsert(context)
                },
                child: Text(getButtonCaption())
            )
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: <Widget>[
          const NavigationDestination(
            icon: Icon(Icons.bar_chart_rounded),
            label: 'Dashboard',
          ),
          const NavigationDestination(
            icon: Icon(Icons.bloodtype_outlined),
            label: 'Glucose',
          ),
          const NavigationDestination(
            icon: Icon(Icons.fastfood_outlined),
            label: 'Bread units',
          ),
          NavigationDestination(
            icon: Icon(UIcons.regularStraight.medicine),
            label: 'Insulin',
          ),
        ],
        onDestinationSelected: (int index) {
          setState(() {
            currentView = index;
          });
        },
        indicatorColor: Colors.black12,
        selectedIndex: currentView,
      ),
      body: <Widget>[
        const DashboardPage(),
        glucosePage,
        breadUnitsPage,
        insulinPage,
      ][currentView],
    );
  }
}


