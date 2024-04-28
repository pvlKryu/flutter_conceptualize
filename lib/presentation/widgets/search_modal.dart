import 'package:flutter/material.dart';

class SearchModal extends StatelessWidget {
  final List<String> searchHistory;

  const SearchModal({super.key, required this.searchHistory});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const ListTile(
          title: Text(
            'Search History: ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: searchHistory.length,
            itemBuilder: (context, index) {
              final item = searchHistory[index];
              return GestureDetector(
                // onTap: () {
                //   Navigator.pop(context);
                // },
                child: Card(
                  color: Colors.blue.shade50,
                  child: ListTile(
                    title: Text(
                      item,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    // trailing: const Icon(Icons.replay_sharp),
                  ),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
