import 'package:conceptualize/domain/entities/definition_entity.dart';
import 'package:conceptualize/domain/entities/concept_entity.dart';

abstract interface class Repository {
  Future<List<ConceptEntity>> getConceptsBySentences(String sentences);

  Future<DefinitionEntity> getDefinitionByWord(String word);
}
