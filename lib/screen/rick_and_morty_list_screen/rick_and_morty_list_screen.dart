import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/cubit/characters_cubit.dart';
import 'package:rickandmorty/model/characters_model.dart';
import 'package:rickandmorty/screen/rick_and_morty_list_screen/widgets/character_not_found.dart';
import 'widgets/characters_list_count.dart';
import 'widgets/characters_list_view.dart';
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

class CharactersBody extends StatefulWidget {
  const CharactersBody(
      {super.key, required this.characters, required this.canLoad});

  final List<CharacterModel> characters;
  final bool canLoad;

  @override
  State<CharactersBody> createState() => _CharactersBodyState();
}

class _CharactersBodyState extends State<CharactersBody> {
  @override
  Widget build(BuildContext context) {
    late bool canLoad = widget.canLoad;
    return Expanded(
      child: NotificationListener(
        onNotification: (ScrollNotification notification) {
          final current = notification.metrics.pixels + 100;
          final max = notification.metrics.maxScrollExtent;
          if (current >= max && canLoad) {
            canLoad = true;
            BlocProvider.of<CharactersCubit>(context).getCharacters();
          }
          return false;
        },
        child: ListView.separated(
          padding: const EdgeInsets.only(top: 20),
          shrinkWrap: true,
          separatorBuilder: (context, index) => const SizedBox(height: 20),
          itemCount: widget.characters.length,
          itemBuilder: (context, index) => CharactersListView(
            character: widget.characters[index],
          ),
        ),
      ),
    );
  }
}
