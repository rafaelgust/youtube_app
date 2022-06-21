import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../bloc/events/video_events.dart';
import '../bloc/states/video_states.dart';
import '../bloc/video_bloc.dart';

import '../components/video_content.dart';

class VideoView extends StatefulWidget {
  final String? video;
  const VideoView({super.key, this.video});

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  final blocVideo = Modular.get<VideoBloc>();
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _loadVideo('${widget.video}');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _loadVideo(String videoId) {
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );
    blocVideo.add(GetVideo(videoId));
  }

  goToChannel(String channelId) => Modular.to.pushNamed('/channel/$channelId');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
          stream: blocVideo.stream,
          builder: (context, snapshot) {
            if (blocVideo.state is VideoIdle ||
                blocVideo.state is VideoLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (blocVideo.state is VideoError) {
              return const Center(child: Text('error'));
            }

            if (blocVideo.state is VideoSucess) {
              final video = (blocVideo.state as VideoSucess).video;

              return VideoContent(
                playerController: _controller,
                videoInfo: video.first,
                goToChannel: goToChannel,
              );
            }

            return const SizedBox.shrink();
          }),
    );
  }
}
