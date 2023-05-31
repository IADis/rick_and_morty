// ignore_for_file: overridden_fields

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/model/characters_model.dart';
import 'package:rickandmorty/repositories/characters_repository.dart';

class CharactersCubit extends Cubit<CharactersStates> {
  CharactersCubit({required this.charactersRepository})
      : super(InitialState(characters: []));

  final CharactersRepository charactersRepository;

  int currenPage = 0;
  int maxPage = 1;
  List<CharacterModel> characters = [];

  getCharacters() async {
    emit(LoadingState(characters: state.characters));

    try {
      if (currenPage < maxPage) {
        final response = await charactersRepository.getCharacters(
          currentPage: currenPage,
        );
        final CharactersInfoModel character =
            CharactersInfoModel.fromJson(response.data);
        characters = [...state.characters, ...character.results!];
        maxPage = character.info?.pages ?? 1;
        currenPage++;
        emit(SuccessState(characters: characters));
      }
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.unknown) {
          emit(ErrorState(
              errorMessage: 'There is no internet connection', characters: []));
        }
        if (e.response?.statusCode == 404) {
          emit(ErrorState(
              errorMessage: 'A character with that name was not found.',
              characters: []));
        }
      }
    }
  }

  getCharactersByName(String name) async {
    emit(LoadingState(characters: state.characters));

    try {
      if (name.isNotEmpty) {
        final response = await charactersRepository.getCharacters(
          name: name,
        );
        final CharactersInfoModel character =
            CharactersInfoModel.fromJson(response.data);
        characters = character.results!;

        emit(SuccessState(characters: characters));
      }
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.unknown) {
          emit(ErrorState(
              errorMessage: 'There is no internet connection', characters: []));
        }
        if (e.response?.statusCode == 404) {
          emit(ErrorState(
              errorMessage: 'A character with that name was not found.',
              characters: []));
        }
      }
    }
  }
}

abstract class CharactersStates {
  CharactersStates({
    required this.characters,
  });
  final List<CharacterModel> characters;
}

class InitialState extends CharactersStates {
  @override
  final List<CharacterModel> characters;
  InitialState({
    required this.characters,
  }) : super(characters: characters);
}

class LoadingState extends CharactersStates {
  @override
  final List<CharacterModel> characters;
  LoadingState({
    required this.characters,
  }) : super(characters: characters);
}

class SuccessState extends CharactersStates {
  @override
  final List<CharacterModel> characters;
  SuccessState({
    required this.characters,
  }) : super(characters: characters);
}

class ErrorState extends CharactersStates {
  ErrorState({required this.errorMessage, required this.characters})
      : super(characters: characters);
  final String errorMessage;
  @override
  final List<CharacterModel> characters;
}
