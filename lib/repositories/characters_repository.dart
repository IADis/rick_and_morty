import 'package:dio/dio.dart';

class CharactersRepository {
  CharactersRepository({required this.dio});
  final Dio dio;

  Future<Response> getCharacters(String? name) async {
    return await dio.get(
      'character',
      queryParameters: {'name': name},
    );
  }
}
