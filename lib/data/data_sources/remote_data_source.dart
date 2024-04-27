import 'package:conceptualize/data/models/definition_dto.dart';
import 'package:conceptualize/data/models/concept_dto.dart';
import 'package:conceptualize/data/network/check_net_errors.dart';
import 'package:conceptualize/data/network/datamuse_api.dart';
import 'package:conceptualize/data/network/dictionary_api.dart';

abstract interface class RemoteDataSource {
  /// Get concepts
  Future<List<ConceptDto>> fetchConcepts(String sentence);

  /// Get definition by word
  Future<List<DefinitionDto>> fetchDefinition(String word);
}

final class RemoteDataSourceImpl implements RemoteDataSource {
  final DatamuseApi _datamuseApi;
  final DictionaryApi _dictionaryApi;

  const RemoteDataSourceImpl({
    required DatamuseApi datamuseApi,
    required DictionaryApi dictionaryApi,
  })  : _dictionaryApi = dictionaryApi,
        _datamuseApi = datamuseApi;

  @override
  Future<List<ConceptDto>> fetchConcepts(String sentence) async {
    return checkNetErrors(() => _datamuseApi.getConceptsBySentence(sentence));
  }

  @override
  Future<List<DefinitionDto>> fetchDefinition(String word) async {
    return checkNetErrors(() => _dictionaryApi.getDefinitionByWord(word));
  }
}
