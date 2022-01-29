import 'package:calorie_counter/Global Vals/global_vals.dart' as globals;
import 'package:calorie_counter/screens/add_meal.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

List _dinner = globals.dinner;

class _DinnerState extends State<Dinner> {
  final _biggerFont =
      const TextStyle(color: globals.accentHexColor, fontSize: 18.0);
  Widget _buildDinner() {
    Tuple3 _foodItem = widget.foodInfo.item1;
    bool _shouldAdd = widget.foodInfo.item2;
    if (_foodItem.item3 == "Dinner") {
      if (_shouldAdd == true) {
        _addItem(_foodItem);
        widget.foodInfo = const Tuple2(Tuple3('air', 0, "dinner"), false);
        _shouldAdd = false;
      }
    }
    ScrollController scrollController =
        ScrollController(initialScrollOffset: 0);
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        controller: scrollController,
        itemCount: _dinner.length,
        itemBuilder: (context, i) {
          return Card(
            color: globals.mainHexColor,
            child: ListTile(
              contentPadding: const EdgeInsets.all(10),
              textColor: globals.accentHexColor,
              title: Text(
                'Meal: ' +
                    _dinner[i].item1.toString() +
                    '       Calories: ' +
                    _dinner[i].item2.toString(),
                style: _biggerFont,
              ),
              trailing: const Icon(
                Icons.delete_forever,
                semanticLabel: 'Delete',
                color: globals.accentHexColor,
              ),
              onTap: () {
                SnackBar snackBar = const SnackBar(
                  content: Text('Meal Removed'),
                  backgroundColor: Color.fromARGB(255, 5, 29, 48),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                setState(() {
                  _dinner.removeAt(i);
                });
                _buildDinner();
              },
            ),
          );
        });
  }

  Widget buildEmpty(BuildContext context) {
    return const SizedBox.shrink();
  }

  _addItem(Tuple3 foodItem) {
    _dinner.add(foodItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Dinner',
            style: TextStyle(
                color: globals.accentHexColor, fontWeight: FontWeight.w300),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _addMeal,
              tooltip: 'Add a meal',
              color: globals.accentHexColor,
            )
          ],
        ),
        backgroundColor: globals.mainHexColor,
        body: _buildDinner());
  }

  void _addMeal() async {
    final information = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddMeal(),
      ),
    );
    setState(() {
      if (information != null) {
        widget.foodInfo = information;
        if (information.item2 == true) {
          Tuple3 meal = information.item1;
          if (meal.item3 == 'Lunch') {
            globals.lunch.add(meal);
          } else if (meal.item3 == 'Breakfast') {
            globals.breakfast.add(meal);
          } else if (meal.item3 == 'Snack') {
            globals.snack.add(meal);
          }
        }
      }
    });
  }
}

class Dinner extends StatefulWidget {
  Tuple2<Tuple3, bool> foodInfo;

  Dinner({Key? key, required this.foodInfo}) : super(key: key);

  @override
  _DinnerState createState() => _DinnerState();
}
