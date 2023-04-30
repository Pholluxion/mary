import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mary/features/login/presentation/widgets/widgets.dart';

class WebLoginForm extends StatelessWidget {
  const WebLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 6,
          child: CarouselSlider(
            items: [
              Padding(
                padding: const EdgeInsets.all(64.0),
                child: SvgPicture.asset(
                  'assets/svg/1.svg',
                  semanticsLabel: "",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(64.0),
                child: SvgPicture.asset(
                  'assets/svg/2.svg',
                  semanticsLabel: "",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(64.0),
                child: SvgPicture.asset(
                  'assets/svg/3.svg',
                  semanticsLabel: "",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(64.0),
                child: SvgPicture.asset(
                  'assets/svg/4.svg',
                  semanticsLabel: "",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(64.0),
                child: SvgPicture.asset(
                  'assets/svg/5.svg',
                  semanticsLabel: "",
                ),
              )
            ],
            options: CarouselOptions(
              autoPlay: true,
              autoPlayAnimationDuration: const Duration(seconds: 1),
            ),
          ),
        ),
        const Flexible(
          flex: 3,
          child: AppLoginForm(),
        ),
      ],
    );
  }
}
