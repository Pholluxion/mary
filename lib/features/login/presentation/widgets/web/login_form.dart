import 'package:flutter/material.dart';
import 'package:mary/features/login/presentation/widgets/widgets.dart';

class WebLoginForm extends StatelessWidget {
  const WebLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(flex: 6, child: Container()),
        Flexible(
          flex: 3,
          child: Container(
            color: const Color.fromRGBO(221, 233, 224, 10),
            child: const AppLoginForm(),
          ),
        ),
      ],
    );
  }
}
