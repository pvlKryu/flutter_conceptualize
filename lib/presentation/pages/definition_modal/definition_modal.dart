import 'package:conceptualize/domain/entities/definition_entity.dart';
import 'package:conceptualize/presentation/pages/definition_modal/bloc/definition_modal_bloc.dart';
import 'package:conceptualize/presentation/pages/definition_modal/bloc/definition_modal_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DefinitionModalView extends StatelessWidget {
  const DefinitionModalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DefinitionModalBloc, DefinitionModalState>(
      builder: (context, state) {
        final DefinitionEntity? definitionEntity = state.definitionEntity;
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.isError) {
          return const Center(child: Text('Sorry, something went bad or we could not find your definition'));
        } else {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Wrap(
                children: [
                  Text(definitionEntity?.word ?? "No word provided",
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const Divider(),
                  _buildSectionTitle("Meanings:"),
                  _buildList(definitionEntity?.meanings),
                  const Divider(),
                  _buildSectionTitle("Synonyms:"),
                  _buildList(definitionEntity?.synonyms),
                  const Divider(),
                  _buildSectionTitle("Antonyms:"),
                  _buildList(definitionEntity?.antonyms),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildList(List<String>? items) {
    return items == null || items.isEmpty
        ? const Text("Not found")
        : Column(
            children: items
                .map((item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(item, style: const TextStyle(fontSize: 16)),
                    ))
                .toList(),
          );
  }
}
