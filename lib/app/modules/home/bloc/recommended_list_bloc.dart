import 'package:bloc/bloc.dart';

import '../repositories/recommended_list_repository.dart';
import 'events/recommended_list_events.dart';
import 'states/recommended_list_states.dart';

class RecommendedListBloc
    extends Bloc<RecommendedListEvents, RecommendedListStates> {
  final IRecommendedListRepository repository;
  RecommendedListBloc(this.repository) : super(InitialRecommendedList()) {
    on<CallRecommendedListEvent>((event, emit) => getResult);
  }

  getResult(CallRecommendedListEvent event,
      Emitter<RecommendedListStates> emit) async {
    emit(LoadingRecommendedList());
    final list = await repository.getList(event.recommendedBySearch);
    emit(SucessRecommendedList(list));
  }
}
