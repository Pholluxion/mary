import 'package:flutter/material.dart';

abstract class UiBreakpoints {
  static const double small = 730;
  static const double medium = 1200;
  static const double large = 1920;
}

typedef ResponsiveLayoutWidgetBuilder = Widget Function(BuildContext, Widget?);

class ResponsiveLayoutBuilder extends StatelessWidget {
  const ResponsiveLayoutBuilder({
    Key? key,
    required this.small,
    required this.large,
    this.medium,
    this.xLarge,
    this.child,
  }) : super(key: key);

  final ResponsiveLayoutWidgetBuilder small;

  final ResponsiveLayoutWidgetBuilder? medium;

  final ResponsiveLayoutWidgetBuilder large;

  final ResponsiveLayoutWidgetBuilder? xLarge;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= UiBreakpoints.small) {
          return small(context, child);
        } else if (constraints.maxWidth <= UiBreakpoints.medium) {
          return (medium ?? large).call(context, child);
        } else if (constraints.maxWidth <= UiBreakpoints.large) {
          return large(context, child);
        } else {
          return (xLarge ?? large).call(context, child);
        }
      },
    );
  }
}
