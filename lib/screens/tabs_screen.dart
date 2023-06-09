import 'package:flutter/material.dart';
import 'package:foods/components/main_drawer.dart';
import 'package:foods/models/meal.dart';
import 'package:foods/screens/categories_screen.dart';
import 'package:foods/screens/favorite_screen.dart';

class TabsScreen extends StatefulWidget {

  final List<Meal> favoriteMeals;


  const TabsScreen(this.favoriteMeals,{Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedScreenIndex = 0;
  late List<Map<String, Object>> _screens;

  _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _screens = [
      {'title': 'Lista de Categorias', 'screen': const CategoriesScreen()},
      {'title': 'Meus Favoritos', 'screen': FavoriteScreen(widget.favoriteMeals)},
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _screens[_selectedScreenIndex]['title'] as String,
        ),
        centerTitle: true,
      ),
      body: _screens[_selectedScreenIndex]['screen'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        backgroundColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        currentIndex: _selectedScreenIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Categorias'),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favoritos',
          ),
        ],
      ),
      drawer: const MainDrawer(),
    );
  }
}
