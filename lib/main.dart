import 'package:flutter/material.dart';
import 'package:mealsmax/dummy_data.dart';
import 'package:mealsmax/models/meal.dart';

import './screens/filters_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';
import './screens/category_meals_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String , bool> _filters ={
    'gluten' : false,
    'lactose' : false,
    'vegan' : false,
    'vegetarian' : false,
  };
  List<Meal> _availabelMeal = DUMMY_MEALS;
  List<Meal> _favoriteMeal=[];
  void _setFilters(Map<String , bool> filtersData){
    setState(() {
      _filters =filtersData;
      _availabelMeal=DUMMY_MEALS.where((meal) {
        if(_filters['gluten']! &&!meal.isGlutenFree){
          return false;
        }
        if(_filters['lactose']! &&!meal.isLactoseFree){
          return false;
        }
        if(_filters['vegan']! &&!meal.isVegan){
          return false;
        }
        if(_filters['vegetarian']! &&!meal.isVegetarian){
          return false;
        }
        return true;
      }).toList();
    },);
  }
  void _toggleFavorite(String mealId){
    final existingIndex= _favoriteMeal.indexWhere((meal) => meal.id ==mealId);
    if (existingIndex>= 0 ) {
      setState(() {
      _favoriteMeal.removeAt(existingIndex);
      });
    }else{
      setState(() {
        _favoriteMeal.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      });
    }
  }
  bool _isFavorite(String id){
    return _favoriteMeal.any((meal) => meal.id==id);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dali Meals',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          color: Colors.pink,
          foregroundColor: Colors.white,
        ),
        primaryColor: Colors.pink,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pink,
          secondary: Colors.amber,
        ),
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyLarge: const TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyMedium: const TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            titleSmall: const TextStyle(
              fontFamily: 'RobotoCondensed',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        useMaterial3: true,
      ),
      // home: const CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(_favoriteMeal),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(_availabelMeal),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavorite,_isFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_setFilters),
      },
    );
  }
}
