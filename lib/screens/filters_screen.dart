import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  Function saveFilters;
  FiltersScreen(this.saveFilters, {super.key});
  static const routeName = '/filters';

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _lactoseFree = false;
  var _vegetarian = false;
  var _vegan = false;

  Widget _buildSwitchListTile(String title, String descreption,
      bool currentValue, Function(bool)? updateValue) {
    return SwitchListTile(
      inactiveThumbColor: Colors.black,
      inactiveTrackColor: Colors.grey,
      activeColor: Theme.of(context).colorScheme.secondary,
      value: currentValue,
      onChanged: updateValue,
      title: Text(
        title,
      ),
      subtitle: Text(descreption),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: [
          IconButton(
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFilters(selectedFilters);
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjsut your meal selection',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile(
                  'GlutenFree',
                  'Only include gluten-free meals',
                  _glutenFree,
                  (newValue) {
                    setState(() {
                      _glutenFree = newValue;
                    });
                  },
                ),
                _buildSwitchListTile(
                    'LactoesFree',
                    'Only include lactoes-free meals',
                    _lactoseFree, (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                }),
                _buildSwitchListTile(
                    'Vegan', 'Only include vegan meals', _vegan, (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                }),
                _buildSwitchListTile(
                    'Vegetarian', 'Only include vegetarian meals', _vegetarian,
                    (newValue) {
                  setState(() {
                    _vegetarian = newValue;
                  });
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
