import 'package:conceptualize/domain/repository/repository.dart';
import 'package:conceptualize/domain/use_cases/use_case_result.dart';

final class GetConceptsUseCase {
  final Repository _repository;

  const GetConceptsUseCase({required Repository repository}) : _repository = repository;

  Future<UseCaseResult> call({required String sentence}) async {
    try {
      final result = await _repository.getConceptsBySentences(sentence);
      return UseCaseResult(isSuccesful: true, value: result);
    } catch (e) {
      return UseCaseResult(error: e);
    }
  }
}
