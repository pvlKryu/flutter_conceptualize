import 'package:conceptualize/domain/use_cases/get_concepts_use_case.dart';
import 'package:conceptualize/domain/use_cases/get_definition_use_case.dart';
import 'package:conceptualize/domain/use_cases/use_case_result.dart';
import 'package:conceptualize/presentation/pages/main_screen/bloc/main_screen_event.dart';
import 'package:conceptualize/presentation/pages/main_screen/bloc/main_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreenBloc extends Bloc<MainScreenEvent, MainScreenState> {
  final GetConceptsUseCase _getConceptsUseCase;

  MainScreenBloc({
    required GetConceptsUseCase getConceptsUseCase,
    required GetDefinitionUseCase getDefinitionUseCase,
  })  : 
        _getConceptsUseCase = getConceptsUseCase,
        super(MainScreenState.initial()) {
    on<GetConcepts>(_getConcepts);
    
  }

  void _getConcepts(GetConcepts event, Emitter<MainScreenState> emit) async {
    emit(state.copyWith(isLoading: true));

    UseCaseResult result = await _getConceptsUseCase.call(sentence: event.sentence);

    if (!result.isSuccesful) {
      emit(state.copyWith(isError: true, isLoading: false));
      return;
    }

    emit(state.copyWith(conceptEntitiesList: result.value, isLoading: false));
  }
}
