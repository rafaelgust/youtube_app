import '../../../core/services/fetch_service.dart';
import '../models/video_model.dart';

abstract class IVideoRepository {
  Future call(String? videoId);
}

class VideoRepository implements IVideoRepository {
  final IFetchApi service;

  VideoRepository(this.service);
  @override
  Future call(String? videoId) async {
    var result = await service.apiVideo(videoId!);

    final list =
        (result["items"] as List).map((e) => VideoModel.fromJson(e)).toList();

    return list;
  }
}
