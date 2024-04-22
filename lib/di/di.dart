import 'package:conceptualize/data/data_sources/remote_data_source.dart';
import 'package:conceptualize/data/network/datamuse_api.dart';
import 'package:conceptualize/data/network/dictionary_api.dart';
import 'package:conceptualize/data/repository/repository_impl.dart';
import 'package:conceptualize/domain/repository/repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class BaseDi {
  final GetIt getIt = GetIt.instance;
  final dio = Dio();

  void setUp() {
    getIt.registerLazySingleton<DatamuseApi>(() => DatamuseApi(dio));
    getIt.registerLazySingleton<DictionaryApi>(() => DictionaryApi(dio));

    getIt.registerLazySingleton<RemoteDataSource>(
        () => RemoteDataSourceImpl(datamuseApi: getIt.get(), dictionaryApi: getIt.get()));

    getIt.registerLazySingleton<Repository>(() => RepositoryImpl(remoteDataSource: getIt.get()));
    // getIt.registerFactory<GetAvailibleCurrenciesUseCase>(() => GetAvailibleCurrenciesUseCase(repository: getIt.get()));
  }
}
