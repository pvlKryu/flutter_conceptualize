import 'package:conceptualize/domain/use_cases/get_concepts_use_case.dart';
import 'package:conceptualize/domain/use_cases/get_search_list_use_case.dart';
import 'package:conceptualize/domain/use_cases/save_search_use_case.dart';
import 'package:conceptualize/presentation/pages/main_screen/bloc/main_screen_event.dart';
import 'package:conceptualize/presentation/pages/main_screen/bloc/main_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  final GetConceptsUseCase _getConceptsUseCase;
  final SaveSearchUseCase _saveSearchUseCase;
  final GetSearchListUseCase _getSearchListUseCase;

  MainScreenBloc(
      {required GetConceptsUseCase getConceptsUseCase,
      required SaveSearchUseCase saveSearchUseCase,
      required GetSearchListUseCase getSearchListUseCase})
      : _getConceptsUseCase = getConceptsUseCase,
        _saveSearchUseCase = saveSearchUseCase,
        _getSearchListUseCase = getSearchListUseCase,
        super(MainScreenState.initial()) {
    on<GetConcepts>(_getConcepts);
  }

  void _getConcepts(GetConcepts event, Emitter<MainScreenState> emit) async {
    emit(state.copyWith(isLoading: true));

    final result = await _getConceptsUseCase.call(sentence: event.sentence);

    if (!result.isSuccesful) {
      emit(state.copyWith(isError: true, isLoading: false));
      return;
    }
    _saveSearchUseCase(sentence: event.sentence);
    final searchList = await _getSearchListUseCase.call();
    emit(state.copyWith(conceptEntitiesList: result.value, isLoading: false, searchList: searchList));
  }
}
