sealed class MainScreenEvent {}

final class GetConcepts extends MainScreenEvent {
  final String sentence;

  GetConcepts({required this.sentence});
}

final class GetDefinition extends MainScreenEvent {
  final String word;

  GetDefinition({required this.word});
}
