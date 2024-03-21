import 'package:flutter/material.dart';
import 'package:food_app/Menu.dart';
import 'package:food_app/home.dart';
import 'package:food_app/profile.dart';
import 'package:food_app/provider/categories.dart';
import 'package:food_app/provider/meals.dart';
import 'package:provider/provider.dart';

class Bottom_Nav extends StatefulWidget {
  const Bottom_Nav({super.key});

  @override
  State<Bottom_Nav> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<Bottom_Nav> {
  void initState() {
    //meals
    final mealsProvider =
        Provider.of<MealsProvider>(context as BuildContext, listen: false);
    mealsProvider.getMealFromAPI();

    //category
    final categoryProvider =
        Provider.of<CategoryProvide>(context as BuildContext, listen: false);
    categoryProvider.getCategoryAPI();
  }

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.menu_book_outlined)),
            label: 'Menu',
          ),
          NavigationDestination(
            icon: Badge(
              label: Text('2'),
              child: Icon(Icons.person),
            ),
            label: 'Profile',
          ),
        ],
      ),
      body: <Widget>[
        /// Home page
        Home(),
        Menu(),
        Profile(),

        /// Messages page
      ][currentPageIndex],
    );
  }
}
