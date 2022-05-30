abstract class PlayListEvents {
  final String? playlistId;

  PlayListEvents(this.playlistId);
}

class CallPlayListEvent extends PlayListEvents {
  CallPlayListEvent(super.playlistId);
}
