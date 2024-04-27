import 'package:conceptualize/domain/entities/definition_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'definition_dto.g.dart';

@JsonSerializable(explicitToJson: true, createToJson: false)
class DefinitionDto {
  final String? word;
  final String? phonetic;
  final List<Phonetic>? phonetics;
  final List<Meaning>? meanings;
  final License? license;
  final List<String>? sourceUrls;

  const DefinitionDto({
    this.word,
    this.phonetic,
    this.phonetics,
    this.meanings,
    this.license,
    this.sourceUrls,
  });

  factory DefinitionDto.fromJson(Map<String, dynamic> json) => _$DefinitionDtoFromJson(json);

  DefinitionEntity toEntity() {
    List<String> meanings = [];
    List<String> synonyms = [];
    List<String> antonyms = [];

    for (var meaning in this.meanings ?? []) {
      for (var def in meaning.definitions ?? []) {
        meanings.add(def.definition ?? '');
        synonyms.addAll(def.synonyms ?? []);
        antonyms.addAll(def.antonyms ?? []);
      }
    }
    return DefinitionEntity(word: word, meanings: meanings, synonyms: synonyms, antonyms: antonyms);
  }
}

@JsonSerializable(explicitToJson: true)
class Phonetic {
  final String? text;
  final String? audio;
  final String? sourceUrl;
  final License? license;

  Phonetic({
    this.text,
    this.audio,
    this.sourceUrl,
    this.license,
  });

  factory Phonetic.fromJson(Map<String, dynamic> json) => _$PhoneticFromJson(json);
  Map<String, dynamic> toJson() => _$PhoneticToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Meaning {
  final String? partOfSpeech;
  final List<DefinitionDetail>? definitions;

  Meaning({
    this.partOfSpeech,
    this.definitions,
  });

  factory Meaning.fromJson(Map<String, dynamic> json) => _$MeaningFromJson(json);
  Map<String, dynamic> toJson() => _$MeaningToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DefinitionDetail {
  final String? definition;
  final List<String>? synonyms;
  final List<String>? antonyms;
  final String? example;

  DefinitionDetail({
    this.definition,
    this.synonyms,
    this.antonyms,
    this.example,
  });

  factory DefinitionDetail.fromJson(Map<String, dynamic> json) => _$DefinitionDetailFromJson(json);
  Map<String, dynamic> toJson() => _$DefinitionDetailToJson(this);
}

@JsonSerializable(explicitToJson: true)
class License {
  final String? name;
  final String? url;

  License({
    this.name,
    this.url,
  });

  factory License.fromJson(Map<String, dynamic> json) => _$LicenseFromJson(json);
  Map<String, dynamic> toJson() => _$LicenseToJson(this);
}
