import 'package:flutter/material.dart';
import 'package:rickandmorty/components/app_colors.dart';

class CharacterNotFound extends StatelessWidget {
  const CharacterNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 250,
          width: 250,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/character.png'),
            ),
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'A character with that name was not found.',
          style: TextStyle(color: AppColors.nameColor, fontSize: 15),
        )
      ],
    );
  }
}
