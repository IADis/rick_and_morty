import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/cubit/characters_cubit.dart';
import 'package:rickandmorty/screen/rick_and_morty_list_screen/widgets/character_not_found.dart';
import 'widgets/characters_list_view.dart';
import 'widgets/header.dart';

class RickAndMortyListScreen extends StatelessWidget {
  const RickAndMortyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
        ),
        child: Column(
          children: [
            const SizedBox(height: 30),
            const Header(),
            const SizedBox(height: 20),
            SearchBar(onChanged: (name) {
              BlocProvider.of<CharactersCubit>(context).getCharacters(name);
            }),
            const SizedBox(height: 1),
            BlocBuilder<CharactersCubit, CharactersStates>(
              builder: (context, state) {
                if (state is LoadingState) {
                  return const CircularProgressIndicator();
                }
                if (state is SuccessState) {
                  return Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.only(top: 20),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 20),
                      itemCount: state.characters.results!.length,
                      itemBuilder: (context, index) => CharactersListView(
                        character: state.characters.results![index],
                      ),
                    ),
                  );
                }
                if (state is ErrorState) {
                  return const CharacterNotFound();
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
