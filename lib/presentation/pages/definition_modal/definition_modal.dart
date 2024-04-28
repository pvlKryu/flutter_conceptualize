import 'package:conceptualize/domain/entities/definition_entity.dart';
import 'package:conceptualize/presentation/pages/definition_modal/bloc/definition_modal_bloc.dart';
import 'package:conceptualize/presentation/pages/definition_modal/bloc/definition_modal_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DefinitionModalView extends StatelessWidget {
  const DefinitionModalView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DefinitionModalBloc, DefinitionModalState>(
      builder: (context, state) {
        final DefinitionEntity? definitionEntity = state.definitionEntity;
        final synonyms = definitionEntity?.synonyms ?? [];
        final antonyms = definitionEntity?.antonyms ?? [];

        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.isError) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                'Sorry, something went bad or we could not find your definition. \n \n Please try to choose another word.',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          );
        } else {
          return Container(
            padding: const EdgeInsets.all(20),
            color: Colors.blue.shade50,
            child: SingleChildScrollView(
              child: Wrap(
                children: [
                  Row(
                    children: [
                      Text(definitionEntity?.word ?? "No word provided",
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      IconButton(
                          icon: const Icon(Icons.copy),
                          onPressed: () =>
                              Clipboard.setData(ClipboardData(text: definitionEntity?.word ?? '')).then((value) {
                                final snackBar = SnackBar(
                                  content: Text('Meanings of ${definitionEntity?.word} Copied to Clipboard'),
                                );
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              })),
                    ],
                  ),
                  const Divider(),
                  _buildSectionTitle("Meanings:"),
                  _buildList(definitionEntity?.meanings),
                  if (synonyms.isNotEmpty) ...[
                    const Divider(),
                    _buildSectionTitle("Synonyms:"),
                    _buildList(synonyms),
                  ],
                  if (antonyms.isNotEmpty) ...[
                    const Divider(),
                    _buildSectionTitle("Antonyms:"),
                    _buildList(antonyms),
                  ],
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
        : Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: items
                  .map((item) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "• ",
                              style: TextStyle(fontSize: 16, height: 1.5),
                            ),
                            Expanded(
                              child: Text(
                                item,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          );
  }
}
