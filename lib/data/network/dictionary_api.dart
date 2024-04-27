import 'package:conceptualize/data/models/definition_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'dictionary_api.g.dart';

@RestApi(baseUrl: "https://api.dictionaryapi.dev/")
abstract interface class DictionaryApi {
  factory DictionaryApi(Dio dio, {String baseUrl}) = _DictionaryApi;

  @GET("api/v2/entries/en/{word}")
  Future<List<DefinitionDto>> getDefinitionByWord(@Path('word') String word);
}
