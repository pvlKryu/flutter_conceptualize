import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conceptualize/presentation/pages/main_screen/bloc/main_screen_bloc.dart';
import 'package:conceptualize/presentation/pages/main_screen/bloc/main_screen_event.dart';
import 'package:conceptualize/presentation/pages/main_screen/bloc/main_screen_state.dart';
import 'package:conceptualize/presentation/widgets/search_modal.dart';
import 'package:conceptualize/di/di.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _onSearch() {
    FocusScope.of(context).unfocus();
    context.read<MainScreenBloc>().add(GetConcepts(sentence: _textEditingController.text));
  }

  void _showDefinitionModal(BuildContext context, String word) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return DefinitionModalPage(word: word);
      },
    );
  }

  void _showSearchHistoryModal(BuildContext context, List<String> searchHistory) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SearchModal(
          searchHistory: searchHistory,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainScreenBloc, MainScreenState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Discover Concepts'),
            leading: IconButton(
              icon: const Icon(Icons.history),
              onPressed: () {
                if (state.searchList.isNotEmpty) {
                  _showSearchHistoryModal(context, state.searchList);
                }
              },
            ),
            backgroundColor: Colors.blue,
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                    hintText: 'Enter your topic of interest',
                    prefixIcon: IconButton(onPressed: null, icon: Icon(Icons.search)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                  ),
                  onSubmitted: (_) => _onSearch(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: _onSearch,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    textStyle: const TextStyle(fontSize: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: const Text(
                    'Search',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                child: _buildSearchResults(state),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchResults(MainScreenState state) {
    final listConcepts = state.conceptEntitiesList ?? [];
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state.conceptEntitiesList == null) {
      return const ListTile(
        title: Text('Make any search for getting suggested terms'),
      );
    }
    return Column(
      children: [
        ListTile(
          title: Text(
            listConcepts.isNotEmpty ? 'Relevant terms: ' : 'No matching terms found. Please change your search query',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: state.conceptEntitiesList?.length ?? 0,
            itemBuilder: (context, index) {
              final entity = state.conceptEntitiesList?[index];
              return Card(
                color: Colors.blue.shade50,
                child: ListTile(
                  onTap: () {
                    _showDefinitionModal(context, entity?.word ?? '');
                  },
                  title: Row(
                    children: [
                      Text(
                        '${index + 1}. ',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(entity?.word ?? ''),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
