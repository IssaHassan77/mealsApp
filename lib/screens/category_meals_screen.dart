import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';
  List<Meal> availabelMeal;
  CategoryMealsScreen(this.availabelMeal,{super.key});

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String? categoryTitle;
  List<Meal>? displayedMeal;
  var _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      final categoryId = routArgs['id'];
      categoryTitle = routArgs['title']!;
      displayedMeal = widget.availabelMeal.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeal!.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle!),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              id: displayedMeal![index].id,
              title: displayedMeal![index].title,
              imageUrl: displayedMeal![index].imageUrl,
              complexity: displayedMeal![index].complexity,
              affordability: displayedMeal![index].affordability,
              duration: displayedMeal![index].duration,
            );
          },
          itemCount: displayedMeal!.length,
        ));
  }
}
