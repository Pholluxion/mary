import 'package:flutter/material.dart';

extension FromContext on BuildContext {
  double get getPadding => 16.0;
  Size get getSize => MediaQuery.of(this).size;
  TextTheme get getTextTheme => Theme.of(this).textTheme;
}
