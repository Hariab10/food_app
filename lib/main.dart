import 'package:flutter/material.dart';
import 'package:food_app/bot_nav_.dart';
import 'package:food_app/provider/categories.dart';
import 'package:food_app/provider/meals.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MealsProvider()),
        ChangeNotifierProvider(create: (context) => CategoryProvide()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Bottom_Nav(),
      ),
    );
  }
}
