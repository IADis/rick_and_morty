import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/characters_cubit.dart';
import '../../../model/characters_model.dart';
import 'characters_list_view.dart';

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
          final current = notification.metrics.pixels + 400;
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
