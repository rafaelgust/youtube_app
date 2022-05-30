import '../../models/recommended_list_model.dart';

abstract class RecommendedListStates {}

class InitialRecommendedList extends RecommendedListStates {}

class LoadingRecommendedList extends RecommendedListStates {}

class SucessRecommendedList extends RecommendedListStates {
  final List<RecommendedListModel>? list;

  SucessRecommendedList(this.list);
}

class ErrorRecommendedList extends RecommendedListStates {}
