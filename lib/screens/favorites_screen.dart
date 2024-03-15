import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeal;
  const FavoritesScreen(this.favoriteMeal,{super.key});

  @override
  Widget build(BuildContext context) {
    if (favoriteMeal.isEmpty) {
    return const Center(
      child: Text('You have no favorites yet - start adding some!'),
    );
  }
  else {
      return  ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              id: favoriteMeal[index].id,
              title: favoriteMeal[index].title,
              imageUrl: favoriteMeal[index].imageUrl,
              complexity: favoriteMeal[index].complexity,
              affordability: favoriteMeal[index].affordability,
              duration: favoriteMeal[index].duration,
            );
          },
          itemCount: favoriteMeal.length,
        );
    }
      
    }
}