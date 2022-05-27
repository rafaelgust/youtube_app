import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/services/debounce_service.dart';
import '../bloc/events/search_events.dart';
import '../bloc/search_bloc.dart';
import '../bloc/states/search_states.dart';
import '../components/item_search.dart';

class SearchView extends StatefulWidget {
  final String search;
  const SearchView({super.key, required this.search});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final bloc = Modular.get<SearchBloc>();
  final TextEditingController _searchText = TextEditingController();

  final Debounce debounce = Debounce(const Duration(milliseconds: 800));

  @override
  void initState() {
    super.initState();
    _searchText.text = widget.search;
    bloc.add(SearchListVideoEvent(widget.search));
  }

  @override
  void dispose() {
    debounce.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      icon:
                          const Icon(Icons.arrow_back_ios, color: Colors.black),
                      onPressed: () => Modular.to.navigate('/'),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _searchText,
                        onChanged: (value) => debounce(
                            () => bloc.add(SearchListVideoEvent(value))),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Procurar vídeo',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: StreamBuilder(
                  stream: bloc.stream,
                  builder: (context, snapshot) {
                    if (bloc.state is SearchInitialState) {
                      return const Center(
                        child: Text('Procure um video'),
                      );
                    }
                    if (bloc.state is SearchErrorState) {
                      return const Center(
                        child: Text('Error'),
                      );
                    }
                    if (bloc.state is SearchLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final list = (bloc.state as SearchSucessState).list;

                    return ListView.builder(
                      itemCount: list?.length,
                      itemBuilder: (context, index) => ItemSearch(
                        list![index],
                        goPageVideo: () =>
                            Modular.to.pushNamed('/video/${list[index].id}'),
                        goPageChannel: () => Modular.to
                            .pushNamed('/channel/${list[index].channelId}'),
                      ),
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
