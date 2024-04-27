import 'package:conceptualize/domain/use_cases/get_definition_use_case.dart';
import 'package:conceptualize/domain/use_cases/use_case_result.dart';
import 'package:conceptualize/presentation/pages/definition_modal/bloc/definition_modal_event.dart';
import 'package:conceptualize/presentation/pages/definition_modal/bloc/definition_modal_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DefinitionModalBloc extends Bloc<DefinitionModalEvent, DefinitionModalState> {
  final GetDefinitionUseCase _getDefinitionUseCase;
  final String _word;

  DefinitionModalBloc({
    required GetDefinitionUseCase getDefinitionUseCase,
    required String word,
  })  : _getDefinitionUseCase = getDefinitionUseCase,
        _word = word,
        super(DefinitionModalState.initial()) {
    on<GetDefinition>(_getDefinition);
    add(GetDefinition(word: _word));
  }

  void _getDefinition(GetDefinition event, Emitter<DefinitionModalState> emit) async {
    emit(state.copyWith(isLoading: true));

    UseCaseResult result = await _getDefinitionUseCase.call(word: event.word);

    if (!result.isSuccesful) {
      emit(state.copyWith(isError: true, isLoading: false));
      return;
    }

    emit(state.copyWith(definitionEntity: result.value, isLoading: false));
  }
}
