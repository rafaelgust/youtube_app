import 'package:flutter/material.dart';

class ChannelView extends StatefulWidget {
  final String? channel;
  const ChannelView({super.key, this.channel});

  @override
  State<ChannelView> createState() => _ChannelViewState();
}

class _ChannelViewState extends State<ChannelView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.channel}'),
      ),
      body: Container(),
    );
  }
}
