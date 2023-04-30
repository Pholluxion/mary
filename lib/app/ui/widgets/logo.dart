import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mary/app/ui/ui.dart';

class MaryLogo extends StatelessWidget {
  const MaryLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.getSize.height * 0.2,
      width: context.getSize.height * 0.2,
      child: FittedBox(
        child: SvgPicture.asset(
          'assets/svg/logo.svg',
          semanticsLabel: "",
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
