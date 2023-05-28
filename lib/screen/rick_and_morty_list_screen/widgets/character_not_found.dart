import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/components/app_colors.dart';
import 'package:rickandmorty/cubit/characters_cubit.dart';

class CharacterNotFound extends StatelessWidget {
  const CharacterNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharactersCubit, CharactersStates>(
      builder: (context, state) {
        if (state is ErrorState) {
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
              Text(
                state.errorMessage,
                style:
                    const TextStyle(color: AppColors.nameColor, fontSize: 15),
              )
            ],
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
