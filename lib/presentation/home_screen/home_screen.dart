import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover Concepts'),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Search',
                    hintText: 'Enter your topic of interest',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                  ),
                ),
              ),
              const ListTile(
                title: Text('Suggested Terms'),
              ),
              // Placeholder for suggested terms list
              // Ideally, you would build a list view here based on the search results
              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: 5, // Placeholder count
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.lightbulb_outline),
                      title: Text('Term ${index + 1}'),
                    );
                  },
                ),
              ),
              const ListTile(
                title: Text('Recent Searches'),
              ),
              // Placeholder for recent searches list
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
        ),
      ),
    );
  }
}
