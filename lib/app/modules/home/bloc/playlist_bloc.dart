import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/playlist_repository.dart';

import 'events/playlist_events.dart';
import 'states/playlist_states.dart';

class PlayListBloc extends Bloc<PlayListEvents, PlayListStates> {
  final IPlayListRepository repository;
  PlayListBloc(this.repository) : super(InitialPlayList()) {
    on<CallPlayListEvent>((event, emit) => getPlaylist(event, emit));
  }

  getPlaylist(CallPlayListEvent event, Emitter<PlayListStates> emit) async {
    emit(LoadingPlayList());
    final list = await repository.getList(event.playlistId);
    emit(SucessPlayList(list));
  }
}
