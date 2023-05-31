import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/cubit/characters_cubit.dart';
import 'package:rickandmorty/repositories/characters_repository.dart';
import 'package:rickandmorty/repositories/dio_settings.dart';
import 'package:rickandmorty/router/routes.dart';
import 'package:rickandmorty/theme/theme.dart';

class RickAndMorty extends StatelessWidget {
  const RickAndMorty({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => DioSettings()),
        RepositoryProvider(
          create: (context) => CharactersRepository(
              dio: RepositoryProvider.of<DioSettings>(context).dio),
        ),
      ],
      child: BlocProvider(
        create: (context) => CharactersCubit(
            charactersRepository:
                RepositoryProvider.of<CharactersRepository>(context))
          ..getCharacters(),
        child: MaterialApp(
          theme: theme,
          debugShowCheckedModeBanner: false,
          title: 'Rick and Morty'.toUpperCase(),
          routes: routes,
        ),
      ),
    );
  }
}
