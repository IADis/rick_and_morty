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
      emit(ErrorState());
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

class ErrorState extends CharactersStates {}
