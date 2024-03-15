import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';
import './categories_screen.dart';
import './favorites_screen.dart';
import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  List<Meal> favoriteMeal;
  TabsScreen(this.favoriteMeal, {super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, dynamic>>? _pages;
  int _selectedPageIndex = 0;
  @override
  void initState() {
     _pages = [
    {
      'page': CategoriesScreen(),
      'title': 'Categories',
    },
    {
      'page': FavoritesScreen(widget.favoriteMeal),
      'title': 'Ypur Favorite',
    }
  ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(_pages![_selectedPageIndex]['title']),
          ),
          drawer: MainDrawer(),
          body: _pages![_selectedPageIndex]['page'],
          bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Theme.of(context).primaryColor,
              unselectedItemColor: Colors.white,
              selectedItemColor: Theme.of(context).colorScheme.secondary,
              // type: BottomNavigationBarType.shifting,
              currentIndex: _selectedPageIndex,
              onTap: _selectPage,
              items: [
                BottomNavigationBarItem(
                  backgroundColor: Theme.of(context).primaryColor,
                  icon: Icon(Icons.category),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                    backgroundColor: Theme.of(context).primaryColor,
                    icon: Icon(Icons.star),
                    label: 'Favorites'),
              ]),
        ));
  }
}
