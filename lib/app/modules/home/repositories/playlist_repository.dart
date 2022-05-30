import '../../../core/services/fetch_service.dart';
import '../models/playlist_model.dart';

abstract class IPlayListRepository {
  Future getList(String? playlistId);
}

class PlayListRepository implements IPlayListRepository {
  final IFetchApi service;

  PlayListRepository(this.service);
  @override
  Future getList(String? playlistId) async {
    var result = await service.apiPlaylist(playlistId!);

    final list = (result["items"] as List)
        .map((e) => PlayListModel.fromJson(e))
        .toList();

    return list;
  }
}
