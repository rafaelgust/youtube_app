import 'package:bloc/bloc.dart';

import '../repositories/search_repository.dart';
import 'events/search_events.dart';
import 'states/search_states.dart';

class SearchBloc extends Bloc<SearchEvents, SearchStates> {
  final ISearchRepository repository;

  SearchBloc(this.repository) : super(SearchInitialState()) {
    on<SearchListVideoEvent>((event, emit) => resultListVideo(event, emit));
  }

  resultListVideo(SearchEvents event, Emitter emit) async {
    emit(SearchLoadingState());
    final result = await repository.getListVideos(event.search!);
    emit(SearchSucessState(result));
  }
}
