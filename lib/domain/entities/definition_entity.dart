final class DefinitionEntity {
  final String word;
  final String phonetic;
  final List<PhoneticEntity> phonetics;
  final String origin;
  final List<MeaningEntity> meanings;

  const DefinitionEntity({
    required this.word,
    required this.phonetic,
    required this.phonetics,
    required this.origin,
    required this.meanings,
  });
}

final class PhoneticEntity {
  final String text;
  final String? audio;

  const PhoneticEntity({required this.text, this.audio});
}

final class MeaningEntity {
  final String partOfSpeech;
  final List<DefinitionDetailEntity> definitions;

  const MeaningEntity({required this.partOfSpeech, required this.definitions});
}

final class DefinitionDetailEntity {
  final String definition;
  final String? example;
  final List<String> synonyms;
  final List<String> antonyms;

  const DefinitionDetailEntity({
    required this.definition,
    this.example,
    required this.synonyms,
    required this.antonyms,
  });
}
