import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({super.key});

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _searchText = TextEditingController();
  bool _validate = false;

  _search() {
    if (_searchText.text.isEmpty) {
      setState(() {
        _validate = true;
      });
    } else {
      Modular.to.pushNamed('/search/${_searchText.text}');
    }
  }

  @override
  void dispose() {
    _searchText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              onChanged: (value) => {
                if (_validate)
                  setState(() {
                    _validate = false;
                  })
              },
              onSubmitted: (value) => _search(),
              controller: _searchText,
              decoration: const InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                hintText: 'Procurar vídeo',
              ),
            ),
          ),
          Container(
            width: 50,
            height: 55,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: InkWell(
              child: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              onTap: () => _search(),
            ),
          )
        ],
      ),
    );
  }
}
