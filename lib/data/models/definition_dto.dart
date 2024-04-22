import 'package:conceptualize/domain/entities/definition_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'definition_dto.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
final class DefinitionDto {
  final String word;
  final String phonetic;
  final List<Phonetic> phonetics;
  final String origin;
  final List<Meaning> meanings;

  const DefinitionDto({
    required this.word,
    required this.phonetic,
    required this.phonetics,
    required this.origin,
    required this.meanings,
  });

  factory DefinitionDto.fromJson(Map<String, dynamic> json) => _$DefinitionDtoFromJson(json);

  DefinitionEntity toEntity() {
    var phoneticEntities = phonetics.map((e) => PhoneticEntity(text: e.text, audio: e.audio)).toList();

    var meaningEntities = meanings
        .map((m) => MeaningEntity(
              partOfSpeech: m.partOfSpeech,
              definitions: m.definitions
                  .map((d) => DefinitionDetailEntity(
                        definition: d.definition,
                        example: d.example,
                        synonyms: d.synonyms.toList(),
                        antonyms: d.antonyms.toList(),
                      ))
                  .toList(),
            ))
        .toList();

    return DefinitionEntity(
      word: word,
      phonetic: phonetic,
      phonetics: phoneticEntities,
      origin: origin,
      meanings: meaningEntities,
    );
  }
}

@JsonSerializable(explicitToJson: true)
final class Phonetic {
  final String text;
  final String? audio;

  const Phonetic({required this.text, this.audio});

  factory Phonetic.fromJson(Map<String, dynamic> json) => _$PhoneticFromJson(json);

  Map<String, dynamic> toJson() => _$PhoneticToJson(this);
}

@JsonSerializable(explicitToJson: true)
final class Meaning {
  final String partOfSpeech;
  final List<DefinitionDetail> definitions;

  const Meaning({required this.partOfSpeech, required this.definitions});

  factory Meaning.fromJson(Map<String, dynamic> json) => _$MeaningFromJson(json);

  Map<String, dynamic> toJson() => _$MeaningToJson(this);
}

@JsonSerializable()
final class DefinitionDetail {
  final String definition;
  final String? example;
  final List<String> synonyms;
  final List<String> antonyms;

  const DefinitionDetail({
    required this.definition,
    this.example,
    required this.synonyms,
    required this.antonyms,
  });

  factory DefinitionDetail.fromJson(Map<String, dynamic> json) => _$DefinitionDetailFromJson(json);

  Map<String, dynamic> toJson() => _$DefinitionDetailToJson(this);
}
