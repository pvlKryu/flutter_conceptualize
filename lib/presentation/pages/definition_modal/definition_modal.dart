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
        if (state.isLoading) {
          return const DefinitionLoadingView();
        } else if (state.isError) {
          return const DefinitionErrorView();
        }

        return DefinitionContentView(state: state);
      },
    );
  }
}

class DefinitionLoadingView extends StatelessWidget {
  const DefinitionLoadingView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.blue.shade50,
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}

class DefinitionErrorView extends StatelessWidget {
  const DefinitionErrorView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.blue.shade50,
      child: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            'Sorry, something went bad or we could not find your definition. \n \n Please try to choose another word.',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}

class DefinitionContentView extends StatelessWidget {
  final DefinitionModalState state;

  const DefinitionContentView({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final definitionEntity = state.definitionEntity;
    final synonyms = definitionEntity?.synonyms ?? [];
    final antonyms = definitionEntity?.antonyms ?? [];

    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.blue.shade50,
      child: SingleChildScrollView(
        child: Wrap(
          children: [
            DefinitionHeader(definitionEntity: definitionEntity),
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

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
    );
  }

  Widget _buildList(List<String>? items) {
    if (items == null || items.isEmpty) {
      return const Text("Not found");
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items.map((item) => _buildListItem(item)).toList(),
      ),
    );
  }

  Widget _buildListItem(String item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("• ", style: TextStyle(fontSize: 16, height: 1.5)),
          Expanded(child: Text(item, style: const TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}

class DefinitionHeader extends StatefulWidget {
  final DefinitionEntity? definitionEntity;

  const DefinitionHeader({
    Key? key,
    this.definitionEntity,
  }) : super(key: key);

  @override
  State<DefinitionHeader> createState() => _DefinitionHeaderState();
}

class _DefinitionHeaderState extends State<DefinitionHeader> {
  bool _isCopied = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(widget.definitionEntity?.word ?? "No word provided",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        IconButton(
          icon: const Icon(Icons.copy),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: widget.definitionEntity?.meanings.toString() ?? '')).then((_) {
              if (mounted) {
                setState(() {
                  _isCopied = true;
                });
              }
              if (mounted) {
                Future.delayed(const Duration(seconds: 2), () {
                  setState(() {
                    _isCopied = false;
                  });
                });
              }
            });
          },
        ),
        if (_isCopied) const Text("Meanings Copied", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
