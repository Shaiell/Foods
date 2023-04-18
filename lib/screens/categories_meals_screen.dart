import 'package:flutter/material.dart';
import 'package:foods/components/meal_item.dart';
import 'package:foods/models/category.dart';
import 'package:foods/models/meal.dart';

class CategoriesMealsScreen extends StatelessWidget {

  final List<Meal> meals;

  const CategoriesMealsScreen(this.meals,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)?.settings.arguments as Category;

    final categoryMeals = meals.where((meal) {
      return meal.categories.contains(category.id);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: categoryMeals.length,
        itemBuilder: (ctx, index) {
          return MealItem(categoryMeals[index]);
        },
      ),
    );
  }
}
