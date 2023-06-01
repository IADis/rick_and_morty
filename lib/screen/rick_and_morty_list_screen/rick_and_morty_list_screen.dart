import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/cubit/characters_cubit.dart';
import 'package:rickandmorty/screen/rick_and_morty_list_screen/widgets/character_not_found.dart';
import 'widgets/characters_body.dart';
import 'widgets/characters_list_count.dart';
import 'widgets/header.dart';
import 'widgets/searchbar_characters.dart';

class RickAndMortyListScreen extends StatefulWidget {
  const RickAndMortyListScreen({super.key});

  @override
  State<RickAndMortyListScreen> createState() => _RickAndMortyListScreenState();
}

class _RickAndMortyListScreenState extends State<RickAndMortyListScreen> {
  String? name;
  int? count;
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
            const SizedBox(height: 1),
            SearchBarCharacters(
              onChanged: (names) {
                if (names.isEmpty == true) {
                  name = null;
                } else {
                  name = names;
                }
                setState(() {});

                BlocProvider.of<CharactersCubit>(context)
                    .getCharactersByName(names);
              },
            ),
            const SizedBox(height: 10),
            CharactersListCount(
              count: count.toString(),
            ),
            // const SizedBox(height: 10),
            BlocConsumer<CharactersCubit, CharactersStates>(
              listener: (context, state) {
                count = state.characters.length;
                setState(() {});
              },
              builder: (context, state) {
                if (state is ErrorState) {
                  return const CharacterNotFound();
                }
                return state.characters.isNotEmpty
                    ? CharactersBody(
                        characters: state.characters,
                        canLoad: name == null && state is SuccessState,
                      )
                    : const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }
}
