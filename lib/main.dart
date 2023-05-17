  import 'package:flutter/material.dart';
import 'package:news_app/pages/home_page.dart';
  import 'package:news_app/pages/newsScreen.dart';

  void main() {
    runApp(MyApp());
  }

  class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home: HomePage(),
      );
    }
  }
