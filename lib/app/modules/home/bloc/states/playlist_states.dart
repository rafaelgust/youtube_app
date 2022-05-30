import '../../models/playlist_model.dart';

abstract class PlayListStates {}

class InitialPlayList extends PlayListStates {}

class LoadingPlayList extends PlayListStates {}

class SucessPlayList extends PlayListStates {
  final List<PlayListModel>? list;

  SucessPlayList(this.list);
}

class ErrorPlayList extends PlayListStates {}
