import 'package:flutter/material.dart';
import 'package:foods/data/dummy_data.dart';
import 'package:foods/models/meal.dart';
import 'package:foods/models/settings.dart';
import 'package:foods/screens/categories_meals_screen.dart';
import 'package:foods/screens/categories_screen.dart';
import 'package:foods/screens/meal_detail_screen.dart';
import 'package:foods/screens/settings_screen.dart';
import 'package:foods/screens/tabs_screen.dart';
import 'package:foods/utils/app_routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Settings settings = Settings();

  List<Meal> _availableMeals = dummyMeals;
  List<Meal> _favoriteMeals = [];

  void _filterMeals(Settings settings){
    setState(() {
      this.settings = settings;
      _availableMeals = dummyMeals.where((meal) {
        final filterGluten = settings.isGlutenFree && !meal.isGlutenFree;
        final filterLactose = settings.isLactoseFree && !meal.isLactoseFree;
        final filterVegan = settings.isVegan && !meal.isVegan;
        final filterVegetarian = settings.isVegetarian && !meal.isVegetarian;

        return !filterGluten && !filterLactose && !filterVegan && !filterVegetarian;
      }).toList();
    });
  }

  void _toggleFavorite(Meal meal){
    setState(() {
      _favoriteMeals.contains(meal) ? _favoriteMeals.remove(meal): _favoriteMeals.add(meal);
    });
  }

  bool _isFavorite(Meal meal){
    return _favoriteMeals.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vamos Cozinhar?',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.pink,
          secondary: Colors.amber,
        ),
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleLarge: const TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 20,
              ),
              titleMedium: const TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 17,
              ),
              titleSmall: const TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 14,
              ),
            ),
      ),
      routes: {
        AppRoutes.home: (ctx) => TabsScreen(_favoriteMeals),
        AppRoutes.categoriesMeals: (ctx) => CategoriesMealsScreen(_availableMeals),
        AppRoutes.mealsDetail: (ctx) => MeanDetailScreen(_toggleFavorite, _isFavorite),
        AppRoutes.setting: (ctx) => SettingsScreen(settings, _filterMeals),
      },
      onGenerateRoute: (setting) {
        if (setting.name == '/alguma-coisa') {
          return null;
        } else if (setting.name == '/outra-coisa') {
          return null;
        } else {
          return MaterialPageRoute(
              builder: (_) {
                return const CategoriesScreen();
              });
        }
      },
      onUnknownRoute: (setting){
        return MaterialPageRoute(
          builder: (_) {
            return const CategoriesScreen();
          });
      },
    );
  }
}
