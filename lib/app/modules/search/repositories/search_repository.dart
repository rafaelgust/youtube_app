import 'package:youtube_app/app/core/services/fetch_service.dart';
import 'package:youtube_app/app/modules/search/models/search_model.dart';

abstract class ISearchRepository {
  Future getListVideos(String search);
}

class SearchRepository implements ISearchRepository {
  final IFetchApi service;

  SearchRepository(this.service);

  @override
  Future getListVideos(String search) async {
    var result = await service.apiByGet(search, 'search');
    final items =
        (result["items"] as List).map((e) => SearchModel.fromJson(e)).toList();
    return items;
  }
}
