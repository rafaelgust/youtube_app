abstract class RecommendedListEvents {
  final String? recommendedBySearch;

  RecommendedListEvents(this.recommendedBySearch);
}

class CallRecommendedListEvent extends RecommendedListEvents {
  CallRecommendedListEvent(super.recommendedBySearch);
}
