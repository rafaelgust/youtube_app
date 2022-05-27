import '../../models/search_model.dart';

abstract class SearchStates {}

class SearchInitialState extends SearchStates {}

class SearchLoadingState extends SearchStates {}

class SearchSucessState extends SearchStates {
  final List<SearchModel>? list;

  SearchSucessState(this.list);
}

class SearchErrorState extends SearchStates {}
