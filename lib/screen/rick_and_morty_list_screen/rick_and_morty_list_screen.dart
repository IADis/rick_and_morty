import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/cubit/characters_cubit.dart';
import 'package:rickandmorty/screen/rick_and_morty_list_screen/widgets/character_not_found.dart';
import 'widgets/characters_list_view.dart';
import 'widgets/header.dart';
import 'widgets/searchbar_characters.dart';

class RickAndMortyListScreen extends StatelessWidget {
  const RickAndMortyListScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String? name;
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
            SearchBarCharacters(onChanged: (name) {
              BlocProvider.of<CharactersCubit>(context)
                  .getCharactersByName(name);
            }),
            BlocBuilder<CharactersCubit, CharactersStates>(
              builder: (context, state) {
                if (state is ErrorState) {
                  return const CharacterNotFound();
                }
                return state.characters.isNotEmpty
                    ? Expanded(
                        child: NotificationListener(
                          onNotification: (ScrollNotification notification) {
                            final current = notification.metrics.pixels + 100;
                            final max = notification.metrics.maxScrollExtent;
                            if (current >= max) {
                              BlocProvider.of<CharactersCubit>(context)
                                  .getCharacters();
                            }
                            return false;
                          },
                          child: ListView.separated(
                            padding: const EdgeInsets.only(top: 20),
                            shrinkWrap: true,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 20),
                            itemCount: state.characters.length,
                            itemBuilder: (context, index) => CharactersListView(
                              character: state.characters[index],
                            ),
                          ),
                        ),
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
