import 'package:conceptualize/domain/entities/definition_entity.dart';
import 'package:conceptualize/domain/entities/concept_entity.dart';

abstract interface class Repository {
  Future<List<ConceptEntity>> getConceptsBySentences(String sentence);

  Future<DefinitionEntity> getDefinitionByWord(String word);

  void saveSearch(String sentence);

  Future<List<String>> getSearchList();
}
