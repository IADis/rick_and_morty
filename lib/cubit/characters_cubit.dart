import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/model/characters_model.dart';
import 'package:rickandmorty/repositories/characters_repository.dart';

class CharactersCubit extends Cubit<CharactersStates> {
  CharactersCubit({required this.charactersRepository}) : super(InitialState());

  final CharactersRepository charactersRepository;

  Future<void> getCharacters(String name) async {
    emit(LoadingState());
    try {
      final response = await charactersRepository.getCharacters(name);
      final CharactersModel characters =
          CharactersModel.fromJson(response.data);
      emit(SuccessState(characters: characters));
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.unknown) {
          emit(ErrorState(errorMessage: 'There is no internet connection'));
        }
        if (e.response?.statusCode == 404) {
          emit(ErrorState(
              errorMessage: 'A character with that name was not found.'));
        }
      }
    }
  }
}

abstract class CharactersStates {}

class InitialState extends CharactersStates {}

class LoadingState extends CharactersStates {}

class SuccessState extends CharactersStates {
  SuccessState({required this.characters});
  final CharactersModel characters;
}

class ErrorState extends CharactersStates {
  ErrorState({required this.errorMessage});
  final String errorMessage;
}
