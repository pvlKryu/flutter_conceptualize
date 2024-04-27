import 'package:conceptualize/domain/entities/concept_entity.dart';
import 'package:conceptualize/domain/entities/definition_entity.dart';
import 'package:equatable/equatable.dart';

class DefinitionModalState extends Equatable {
  final DefinitionEntity? definitionEntity;
  final bool isLoading;
  final bool isError;
 
  const DefinitionModalState._({
    this.definitionEntity,

    this.isLoading = false,
    this.isError = false,
  });

  factory DefinitionModalState.initial() {
    return const DefinitionModalState._();
  }

  DefinitionModalState copyWith({
    List<ConceptEntity>? conceptEntitiesList,
    DefinitionEntity? definitionEntity,
    String? word,
    String? sentence,
    bool? isLoading,
    bool? isError,
  }) {
    return DefinitionModalState._(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      definitionEntity: definitionEntity ?? this.definitionEntity,
    );
  }

  @override
  List<Object?> get props => [
        definitionEntity,
        isLoading,
        isError,
      ];
}
