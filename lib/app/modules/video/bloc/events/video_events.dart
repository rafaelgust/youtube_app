abstract class VideoEvents {}

class GetVideo extends VideoEvents {
  final String videoId;

  GetVideo(this.videoId);
}
