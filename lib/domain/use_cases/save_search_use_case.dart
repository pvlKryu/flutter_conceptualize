import 'package:conceptualize/domain/repository/repository.dart';

final class SaveSearchUseCase {
  final Repository _repository;

  const SaveSearchUseCase({required Repository repository}) : _repository = repository;

  void call({required String sentence}) {
    _repository.saveSearch(sentence);
  }
}
