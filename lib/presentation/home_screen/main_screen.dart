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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover Concepts'),
        leading: const Icon(Icons.history),
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
              child: const Text(
                'Search',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<MainScreenBloc, MainScreenState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.conceptEntitiesList == null) {
                  return const ListTile(
                    title: Text('Make any search for getting suggested terms'),
                  );
                }
                return ListView.builder(
                  itemCount: state.conceptEntitiesList?.length ?? 0,
                  itemBuilder: (context, index) {
                    final entity = state.conceptEntitiesList?[index];
                    return ListTile(
                      onTap: () => print(''),
                      title: Row(
                        children: [
                          Text(
                            '${index + 1}. ',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('${entity?.word ?? ''} '),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
