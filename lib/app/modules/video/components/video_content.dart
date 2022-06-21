import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../models/video_model.dart';
import 'video_info.dart';

class VideoContent extends StatelessWidget {
  final VideoModel videoInfo;
  final YoutubePlayerController playerController;
  final Function(String channelId) goToChannel;
  const VideoContent({
    super.key,
    required this.playerController,
    required this.videoInfo,
    required this.goToChannel,
  });

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(controller: playerController),
      builder: (context, player) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            player,
            InfoBarVideo(
              author: videoInfo.channelTitle,
              title: videoInfo.title,
              description: videoInfo.description,
              created: videoInfo.publishedAt,
              goPageChannel: () => goToChannel(videoInfo.channelId),
            ),
          ],
        );
      },
    );
  }
}
