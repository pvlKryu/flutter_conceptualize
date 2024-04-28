import 'package:conceptualize/domain/repository/repository.dart';

final class GetSearchListUseCase {
  final Repository _repository;

  const GetSearchListUseCase({required Repository repository}) : _repository = repository;

  Future<List<String>> call() async{
    return await _repository.getSearchList();
  }
}
