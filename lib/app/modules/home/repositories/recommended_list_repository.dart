import '../../../core/services/fetch_service.dart';
import '../models/recommended_list_model.dart';

abstract class IRecommendedListRepository {
  Future getList(String? recommendedBySearch);
}

class RecommendedListRepository extends IRecommendedListRepository {
  final IFetchApi service;

  RecommendedListRepository(this.service);
  @override
  Future getList(String? recommendedBySearch) async {
    var result = await service.apiByGet(recommendedBySearch!, 'search');

    final list = (result["items"] as List)
        .map((e) => RecommendedListModel.fromJson(e))
        .toList();

    return list;
  }
}
