import 'package:conceptualize/domain/repository/repository.dart';
import 'package:conceptualize/domain/use_cases/use_case_result.dart';

final class GetDefinitionUseCase {
  final Repository repository;

  GetDefinitionUseCase({required this.repository});

  Future<UseCaseResult> call({required String word}) async {
    try {
      final result = await repository.getDefinitionByWord(word);
      return UseCaseResult(isSuccesful: true, value: result);
    } catch (e) {
      return UseCaseResult(error: e);
    }
  }
}
