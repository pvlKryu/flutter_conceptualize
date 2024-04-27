sealed class MainScreenEvent {}

final class GetConcepts extends MainScreenEvent {
  final String sentence;

  GetConcepts({required this.sentence});
}
