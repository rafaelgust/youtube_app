import 'package:flutter/material.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoHeader extends StatefulWidget {
  final YoutubePlayerController playerController;
  const VideoHeader({super.key, required this.playerController});

  @override
  State<VideoHeader> createState() => _VideoHeaderState();
}

class _VideoHeaderState extends State<VideoHeader> {
  late double _percent;

  @override
  void initState() {
    super.initState();
    widget.playerController.addListener(_listener);
    _percent = 0.0;
  }

  @override
  void dispose() {
    widget.playerController.removeListener(_listener);
    super.dispose();
  }

  _listener() {
    if (mounted) {
      setState(_percentCalc);
    }
  }

  _percentCalc() {
    int atual = widget.playerController.value.metaData.duration.inSeconds -
        widget.playerController.value.position.inSeconds;
    int total = widget.playerController.value.metaData.duration.inSeconds;

    if (atual > 0) {
      double calc = (total - atual) / total;
      _percent = calc;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: double.infinity,
      height: 80,
      child: LinearProgressIndicator(
        backgroundColor: Colors.transparent,
        color: Colors.blueAccent,
        value: _percent,
      ),
    );
  }
}
