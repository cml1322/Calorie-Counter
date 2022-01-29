import 'dart:developer';

import 'package:calorie_counter/screens/breakfast.dart';
import 'package:calorie_counter/screens/dinner.dart';
import 'package:calorie_counter/screens/lunch.dart';
import 'package:calorie_counter/screens/snack.dart';
import 'package:flutter/material.dart';
import 'package:calorie_counter/screens/add_meal.dart';
import 'package:calorie_counter/Global Vals/global_vals.dart' as globals;
import 'package:tuple/tuple.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget buildHome() {
    return Column(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          decoration: const BoxDecoration(
            color: Colors.grey,
          ),
          child: Center(
            child: Text(
              'Total Calories: ' + getTotalCals(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 30.0,
                backgroundColor: Colors.grey,
              ),
            ),
          ),
        ),
        Expanded(
            child: InkWell(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.green,
            ),
            child: Center(
              child: Text(
                'Breakfast  Calories: ' + getBreakfastCals(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 30.0,
                  backgroundColor: Colors.green,
                ),
              ),
            ),
          ),
          onTap: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Breakfast(
                        foodInfo: const Tuple2(
                            Tuple3('air', 0, 'Breakfast'), false))));
            setState(() {});
          },
        )),
        Expanded(
            child: InkWell(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
              child: Text(
                'Lunch  Calories: ' + getLunchCals(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 30.0,
                  backgroundColor: Colors.blue,
                ),
              ),
            ),
          ),
          onTap: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Lunch(
                        foodInfo:
                            const Tuple2(Tuple3('air', 0, 'Lunch'), false))));
            setState(() {});
          },
        )),
        Expanded(
            child: InkWell(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.red,
            ),
            child: Center(
              child: Text(
                'Dinner  Calories: ' + getDinnerCals(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 30.0,
                  backgroundColor: Colors.red,
                ),
              ),
            ),
          ),
          onTap: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Dinner(
                        foodInfo:
                            const Tuple2(Tuple3('air', 0, 'Dinner'), false))));
            setState(() {});
          },
        )),
        Expanded(
            child: InkWell(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 145, 145, 0),
            ),
            child: Center(
              child: Text(
                'Snack  Calories: ' + getSnackCals(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 30.0,
                  backgroundColor: Color.fromARGB(255, 145, 145, 0),
                ),
              ),
            ),
          ),
          onTap: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Snack(
                        foodInfo:
                            const Tuple2(Tuple3('air', 0, 'Snack'), false))));
            setState(() {});
          },
        )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Calorie Tracker',
            style: TextStyle(
                color: globals.accentHexColor, fontWeight: FontWeight.w300),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                addMeal();
              },
              tooltip: 'Add a meal',
              color: globals.accentHexColor,
            )
          ],
        ),
        backgroundColor: globals.mainHexColor,
        body: buildHome());
  }

  void addMeal() async {
    final information = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddMeal(),
      ),
    );
    setState(() {
      if (information != null) {
        if (information.item2 == true) {
          Tuple3 meal = information.item1;
          if (meal.item3 == 'Breakfast') {
            globals.breakfast.add(meal);
          } else if (meal.item3 == 'Lunch') {
            globals.lunch.add(meal);
          } else if (meal.item3 == 'Dinner') {
            globals.dinner.add(meal);
          } else if (meal.item3 == 'Snack') {
            globals.snack.add(meal);
          } else {
            log(meal.item3);
          }
        }
      }
    });
  }

  String getBreakfastCals() {
    num totalCals = 0;
    List<Tuple3> breakfastItems = globals.breakfast;
    for (int x = 0; x < breakfastItems.length; x++) {
      totalCals += breakfastItems[x].item2;
    }
    return totalCals.toString();
  }

  String getLunchCals() {
    num totalCals = 0;
    List<Tuple3> lunchItems = globals.lunch;
    for (int x = 0; x < lunchItems.length; x++) {
      totalCals += lunchItems[x].item2;
    }
    return totalCals.toString();
  }

  String getDinnerCals() {
    num totalCals = 0;
    List<Tuple3> dinnerItems = globals.dinner;
    for (int x = 0; x < dinnerItems.length; x++) {
      totalCals += dinnerItems[x].item2;
    }
    return totalCals.toString();
  }

  String getSnackCals() {
    num totalCals = 0;
    List<Tuple3> snackItems = globals.snack;
    for (int x = 0; x < snackItems.length; x++) {
      totalCals += snackItems[x].item2;
    }
    return totalCals.toString();
  }

  String getTotalCals() {
    num totalCals = 0;
    List<Tuple3> breakfastItems = globals.breakfast;
    List<Tuple3> lunchItems = globals.lunch;
    List<Tuple3> dinnerItems = globals.dinner;
    List<Tuple3> snackItems = globals.snack;
    for (int x = 0; x < breakfastItems.length; x++) {
      totalCals += breakfastItems[x].item2;
    }
    for (int x = 0; x < lunchItems.length; x++) {
      totalCals += lunchItems[x].item2;
    }
    for (int x = 0; x < dinnerItems.length; x++) {
      totalCals += dinnerItems[x].item2;
    }
    for (int x = 0; x < snackItems.length; x++) {
      totalCals += snackItems[x].item2;
    }
    return totalCals.toString();
  }
}
