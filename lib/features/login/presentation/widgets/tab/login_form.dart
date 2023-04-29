import 'package:flutter/material.dart';
import 'package:mary/app/ui/ui.dart';
import 'package:mary/features/login/presentation/widgets/widgets.dart';

class TabLoginForm extends StatelessWidget {
  const TabLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: UiBreakpoints.small,
        ),
        child: const AppLoginForm(),
      ),
    );
  }
}
