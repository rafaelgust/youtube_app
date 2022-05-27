import 'package:flutter/material.dart';

class VideoView extends StatefulWidget {
  final String? video;
  const VideoView({super.key, this.video});

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.video}')),
      body: Container(),
    );
  }
}
