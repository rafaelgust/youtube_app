abstract class SearchEvents {
  final String? search;

  SearchEvents(this.search);
}

class SearchListVideoEvent extends SearchEvents {
  SearchListVideoEvent(super.search);
}
