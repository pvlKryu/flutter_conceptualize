import 'package:conceptualize/data/data_sources/remote_data_source.dart';
import 'package:conceptualize/data/network/custom_interceptors.dart';
import 'package:conceptualize/data/network/datamuse_api.dart';
import 'package:conceptualize/data/network/dictionary_api.dart';
import 'package:conceptualize/data/repository/repository_impl.dart';
import 'package:conceptualize/domain/repository/repository.dart';
import 'package:conceptualize/domain/use_cases/get_concepts_use_case.dart';
import 'package:conceptualize/domain/use_cases/get_definition_use_case.dart';
import 'package:conceptualize/domain/use_cases/get_search_list_use_case.dart';
import 'package:conceptualize/domain/use_cases/save_search_use_case.dart';
import 'package:conceptualize/presentation/pages/definition_modal/bloc/definition_modal_bloc.dart';
import 'package:conceptualize/presentation/pages/definition_modal/definition_modal.dart';
import 'package:conceptualize/presentation/pages/main_screen/bloc/main_screen_bloc.dart';
import 'package:conceptualize/presentation/pages/main_screen/main_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class BaseDi {
  final GetIt getIt = GetIt.instance;
  final dio = Dio();

  void setUp() {
    dio.interceptors.add(CustomInterceptors());

    getIt.registerLazySingleton<DatamuseApi>(() => DatamuseApi(dio));
    getIt.registerLazySingleton<DictionaryApi>(() => DictionaryApi(dio));

    getIt.registerLazySingleton<RemoteDataSource>(
        () => RemoteDataSourceImpl(datamuseApi: getIt.get(), dictionaryApi: getIt.get()));

    getIt.registerLazySingleton<Repository>(() => RepositoryImpl(remoteDataSource: getIt.get()));
    getIt.registerFactory<GetConceptsUseCase>(() => GetConceptsUseCase(repository: getIt.get()));
    getIt.registerFactory<GetDefinitionUseCase>(() => GetDefinitionUseCase(repository: getIt.get()));
    getIt.registerFactory<GetSearchListUseCase>(() => GetSearchListUseCase(repository: getIt.get()));
    getIt.registerFactory<SaveSearchUseCase>(() => SaveSearchUseCase(repository: getIt.get()));
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  GetIt get getIt => GetIt.I;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainScreenBloc>(
      create: (_) => MainScreenBloc(
        getConceptsUseCase: getIt(),
        saveSearchUseCase: getIt(),
        getSearchListUseCase: getIt(),
      ),
      child: const MainScreen(),
    );
  }
}

class DefinitionModalPage extends StatelessWidget {
  const DefinitionModalPage({super.key, required this.word});

  final String word;

  GetIt get getIt => GetIt.I;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DefinitionModalBloc>(
      create: (_) => DefinitionModalBloc(
        getDefinitionUseCase: getIt(),
        word: word,
      ),
      child: const DefinitionModalView(),
    );
  }
}
