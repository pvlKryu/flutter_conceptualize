import 'package:conceptualize/presentation/home_screen/bloc/bloc/main_screen_bloc.dart';
import 'package:conceptualize/presentation/home_screen/bloc/bloc/main_screen_event.dart';
import 'package:conceptualize/presentation/home_screen/bloc/bloc/main_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _onSearch() {
    FocusScope.of(context).unfocus();
    context.read<MainScreenBloc>().add(GetConcepts(sentence: _textEditingController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover Concepts'),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: BlocBuilder<MainScreenBloc, MainScreenState>(builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      labelText: 'Search',
                      hintText: 'Enter your topic of interest',
                      prefixIcon: Icon(Icons.search),
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
                    child: const Text('Search', style: TextStyle(color: Colors.black),),
                  ),
                ),
                if (state.isLoading) const CircularProgressIndicator(),
                if (state.conceptEntitiesList != null) ...[
                  const ListTile(
                    title: Text('Suggested Terms in Relevant Order'),
                  ),
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      itemCount: state.conceptEntitiesList?.length ?? 0,
                      itemBuilder: (context, index) {
                        final entity = state.conceptEntitiesList?[index];
                        return ListTile(
                          leading: const Icon(Icons.lightbulb_outline),
                          title: Text('${index + 1} ${entity?.word ?? ''} '),
                        );
                      },
                    ),
                  ),
                ],
                if (state.conceptEntitiesList == null)
                  const ListTile(
                    title: Text('Make any search for getting suggested terms'),
                  ),
                const ListTile(
                  title: Text('Recent Searches'),
                ),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    itemCount: 5, // Placeholder count
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.history),
                        title: Text('Search ${index + 1}'),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
