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
  late YoutubePlayerController controller;

  int _volume = 100;
  bool _muted = false;

  @override
  void initState() {
    super.initState();
    _loadVideo('${widget.video}');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _loadVideo(String videoId) {
    blocVideo.add(GetVideo(videoId));
    controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
      ),
    );
  }

  mute() {
    _muted ? controller.unMute() : controller.mute();
    setState(() {
      _muted = !_muted;
    });
  }

  volume(bool setVolume) {
    if (setVolume && _volume < 100) {
      _volume = _volume + 10;
    }

    if (!setVolume && _volume > 0) {
      _volume = _volume - 10;
    }

    controller.setVolume(_volume);
    if (_volume == 0) {
      controller.mute();
      setState(() {
        _muted = true;
      });
    }

    if (_muted && _volume > 0) {
      controller.unMute();
      setState(() {
        _muted = false;
      });
    }
  }

  goToChannel(String channelId) => Modular.to.pushNamed('/channel/$channelId');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Modular.to.pop(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.remove,
              color: Colors.white,
            ),
            onPressed: () => volume(false),
          ),
          IconButton(
            icon: Icon(
              _muted ? Icons.volume_off : Icons.volume_up,
              color: Colors.white,
            ),
            onPressed: mute,
          ),
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () => volume(true),
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: StreamBuilder(
        stream: blocVideo.stream,
        builder: (context, snapshot) {
          if (blocVideo.state is VideoIdle || blocVideo.state is VideoLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (blocVideo.state is VideoError) {
            return const Center(child: Text('error'));
          }

          if (blocVideo.state is VideoSucess) {
            final video = (blocVideo.state as VideoSucess).video;

            return VideoContent(
              playerController: controller,
              videoInfo: video.first,
              goToChannel: goToChannel,
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
