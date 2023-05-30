import 'package:dio/dio.dart';

class CharactersRepository {
  CharactersRepository({required this.dio});
  final Dio dio;

  Future<Response> getCharacters({
    required String name,
    required int currentPage,
  }) async {
    return await dio.get(
      'character',
      queryParameters: {
        'name': name,
        'page': currentPage,
      },
    );
  }
}
