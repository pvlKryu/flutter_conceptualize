import 'package:conceptualize/domain/entities/concept_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'concept_dto.g.dart';

@JsonSerializable(createToJson: false)
final class ConceptDto {
  final String? word;
  final int? score;
  final List<String>? tags;

  const ConceptDto({this.word, this.score, this.tags});

  factory ConceptDto.fromJson(Map<String, dynamic> json) => _$ConceptDtoFromJson(json);

  ConceptEntity toEntity() => ConceptEntity(word: word, score: score, tags: tags);
}
