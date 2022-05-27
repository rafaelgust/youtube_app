import 'package:flutter/material.dart';

import '../../../core/services/debounce_service.dart';

class SearchView extends StatefulWidget {
  final String search;
  const SearchView({super.key, required this.search});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _searchText = TextEditingController();

  final Debounce debounce = Debounce(const Duration(milliseconds: 800));

  @override
  void initState() {
    _searchText.text = widget.search;
    super.initState();
  }

  @override
  void dispose() {
    debounce.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.search),
      ),
      body: Container(),
    );
  }
}
