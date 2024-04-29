import 'package:conceptualize/data/data_sources/remote_data_source.dart';
import 'package:conceptualize/domain/entities/definition_entity.dart';
import 'package:conceptualize/domain/entities/concept_entity.dart';
import 'package:conceptualize/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  // ignore: prefer_final_fields
  Set<String> _searchList = {};

  RepositoryImpl({required RemoteDataSource remoteDataSource}) : _remoteDataSource = remoteDataSource;

  @override
  Future<List<ConceptEntity>> getConceptsBySentences(String sentence) async {
    try {
      final listDto = await _remoteDataSource.fetchConcepts(sentence);
      return listDto.map((dto) => dto.toEntity()).toList();
    } catch (e) {
      // Handle exceptions from data source or during mapping
      throw Exception('Failed to load concepts: $e');
    }
  }

  @override
  Future<DefinitionEntity> getDefinitionByWord(String word) async {
    try {
      final dto = await _remoteDataSource.fetchDefinition(word);
      return dto[0].toEntity();
    } catch (e) {
      // Handle exceptions from data source or during mapping
      throw Exception('Failed to load definition: $e');
    }
  }

  @override
  Future<List<String>> getSearchList() async {
    return _searchList.toList();
  }

  @override
  void saveSearch(String sentence) {
    _searchList.add(sentence);
  }
}
