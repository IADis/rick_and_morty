import 'package:flutter/material.dart';
import 'package:rickandmorty/components/app_images.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppImages.rick,
          scale: 7,
        ),
        Image.asset(
          AppImages.and,
          scale: 3,
        ),
        Image.asset(
          AppImages.morty,
          scale: 7,
        ),
      ],
    );
  }
}
