// ignore_for_file: file_names
// claims there's upper case characters in file names-known VSCode bug

import 'package:calorie_counter/Global Vals/global_vals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class _AddMealState extends State<AddMeal> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final List<String> _meals = ['Breakfast', 'Lunch', 'Dinner', 'Snack'];
  String _selectedMeal = 'Breakfast';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Meal',
          style: TextStyle(
              color: globals.accentHexColor, fontWeight: FontWeight.w300),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: globals.mainHexColor,
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 130,
                child: DropdownButton(
                  hint: Text(
                    _selectedMeal,
                    style: const TextStyle(color: globals.accentHexColor),
                  ),
                  style: const TextStyle(color: globals.accentHexColor),
                  iconEnabledColor: globals.accentHexColor,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedMeal = newValue!;
                      _meals.remove(_selectedMeal);
                      _meals.insert(0, _selectedMeal);
                    });
                  },
                  items: _meals.map((meal) {
                    return DropdownMenuItem(
                      child: Text(
                        meal,
                        style: const TextStyle(color: globals.accentHexColor),
                      ),
                      value: meal,
                    );
                  }).toList(),
                  dropdownColor: globals.mainHexColor,
                ),
              ),
              SizedBox(
                width: 130,
                child: TextField(
                  controller: _nameController,
                  style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w300,
                      color: globals.accentHexColor),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Food',
                    hintStyle: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w300,
                        color: Colors.white.withOpacity(.8)),
                  ),
                ),
              ),
              SizedBox(
                width: 130,
                child: TextField(
                  controller: _caloriesController,
                  style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.w300,
                      color: globals.accentHexColor),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Calories',
                    hintStyle: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.w300,
                        color: Colors.white.withOpacity(.8)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              String _name = _nameController.text.toString();
                  double _cals = double.parse(_caloriesController.text);
              Tuple3 _items =
                  Tuple3<String, double, String>(_name, _cals, _selectedMeal);
              Navigator.pop(context, Tuple2(_items, true));
            },
            child: const Text(
              'Submit',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: globals.accentHexColor),
            ),
          ),
        ],
      )),
    );
  }
}

class AddMeal extends StatefulWidget {
  const AddMeal({Key? key}) : super(key: key);

  @override
  _AddMealState createState() => _AddMealState();
}
