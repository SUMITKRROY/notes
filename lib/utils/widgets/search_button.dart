import 'package:flutter/material.dart';


class CustomSearch extends StatefulWidget {
  final String title;
  final List<String> data;
  final Function(List<String>) onSearchResultsChanged;

  CustomSearch({required this.data, required this.onSearchResultsChanged, required this.title});

  @override
  _CustomSearchState createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {
  late TextEditingController _searchController;
  bool isSearching = false;
  List<String> searchResults = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void onQueryChanged(String query) {
    setState(() {
      searchResults = widget.data
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
      widget.onSearchResultsChanged(searchResults);
    });
  }

  void startSearch() {
    setState(() {
      isSearching = true;
    });
  }

  void stopSearch() {
    setState(() {
      isSearching = false;
      _searchController.clear();
      searchResults.clear();
      widget.onSearchResultsChanged([]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: isSearching
          ? TextField(
        controller: _searchController,
        onChanged: onQueryChanged,
        decoration: InputDecoration(
          hintText: 'Search...',
          border: InputBorder.none,
        ),
      )
          : Text(widget.title),
      actions: isSearching
          ? [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: stopSearch,
        ),
      ]
          : [
        IconButton(
          icon: Icon(Icons.search),
          onPressed: startSearch,
        ),
      ],
    );
  }
}

class ActionPage extends StatefulWidget {
  @override
  _ActionPageState createState() => _ActionPageState();
}

class _ActionPageState extends State<ActionPage> {
  List<String> data = [
    'Apple',
    'Banana',
    'Cherry',
    'Date',
    'Elderberry',
    'Fig',
    'Grapes',
    "678565",
    'Honeydew',
    'Kiwi',
    'Lemon',
  ];

  List<String> searchResults = [];

  void updateSearchResults(List<String> results) {
    setState(() {
      searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomSearch(
          data: data,
          onSearchResultsChanged: updateSearchResults, title: '',
        ),
      ),

      body: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(searchResults[index]),
          );
        },
      ),
    );
  }
}
