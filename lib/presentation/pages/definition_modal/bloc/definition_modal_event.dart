sealed class DefinitionModalEvent {}

final class GetDefinition extends DefinitionModalEvent {
  final String word;

  GetDefinition({required this.word});
}
