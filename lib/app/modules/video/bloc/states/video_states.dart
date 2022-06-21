import '../../models/video_model.dart';

abstract class VideoStates {}

class VideoIdle extends VideoStates {}

class VideoLoading extends VideoStates {}

class VideoSucess extends VideoStates {
  final List<VideoModel> video;

  VideoSucess(this.video);
}

class VideoError extends VideoStates {}
