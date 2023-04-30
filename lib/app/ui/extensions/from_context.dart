import 'package:flutter/material.dart';

extension FromContext on BuildContext {
  double get getPadding => 16.0;
  Size get getSize => MediaQuery.of(this).size;
  TextTheme get getTextTheme => Theme.of(this).textTheme;
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get cardColor => Theme.of(this).cardColor;
  Color get inversePrimaryColor => Theme.of(this).colorScheme.inversePrimary;
}
