import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../screens/category_screens.dart';

class SingleCategory extends StatelessWidget {
  final Category category;
  SingleCategory(this.category);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            CategoryScreens.routeName,
            arguments: category.id,
          );
        },
        child: Card(
          color: Theme.of(context).accentColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              category.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}