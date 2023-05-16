import 'package:flutter/material.dart';
import 'package:news_app/pages/news_category.dart';


class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NewsCategoryScreen(category: 'General');
  }
}