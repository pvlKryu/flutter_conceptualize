import 'package:conceptualize/domain/entities/concept_entity.dart';
import 'package:conceptualize/domain/entities/definition_entity.dart';
import 'package:equatable/equatable.dart';

class MainScreenState extends Equatable {
  final List<ConceptEntity>? conceptEntitiesList;
  final bool isLoading;
  final bool isError;
  final String? word;
  final String? sentence;
  final List<String> searchList;

  const MainScreenState._({
    this.conceptEntitiesList,
    this.word,
    this.sentence,
    this.isLoading = false,
    this.isError = false,
    this.searchList = const [],
  });

  factory MainScreenState.initial() {
    return const MainScreenState._();
  }

  MainScreenState copyWith({
    List<ConceptEntity>? conceptEntitiesList,
    DefinitionEntity? definitionEntity,
    String? word,
    String? sentence,
    bool? isLoading,
    bool? isError,
    List<String>? searchList,
  }) {
    return MainScreenState._(
      conceptEntitiesList: conceptEntitiesList ?? this.conceptEntitiesList,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      word: word ?? this.word,
      sentence: sentence ?? this.sentence,
      searchList: searchList ?? this.searchList,
    );
  }

  @override
  List<Object?> get props => [
        conceptEntitiesList,
        isLoading,
        isError,
        word,
        sentence,
        searchList,
      ];
}
