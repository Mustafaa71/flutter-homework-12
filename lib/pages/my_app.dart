import 'package:flutter/material.dart';
import 'package:flutter_homework_12/pages/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF1b1c1e),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1b1c1e),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
