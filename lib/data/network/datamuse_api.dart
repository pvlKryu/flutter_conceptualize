import 'package:conceptualize/data/models/concept_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'datamuse_api.g.dart';

@RestApi(baseUrl: "https://api.datamuse.com")
abstract interface class DatamuseApi {
  factory DatamuseApi(Dio dio, {String baseUrl}) = _DatamuseApi;

  @GET("/words?ml={sentence}")
  Future<List<ConceptDto>> getConceptsBySentence(@Path('sentence') String sentence);
}
