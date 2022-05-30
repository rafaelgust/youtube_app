import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:youtube_app/app/modules/home/bloc/states/playlist_states.dart';

import '../bloc/events/playlist_events.dart';
import '../bloc/playlist_bloc.dart';

class PlayList extends StatefulWidget {
  final String? playlistId;
  const PlayList({super.key, required this.playlistId});

  @override
  State<PlayList> createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  final bloc = Modular.get<PlayListBloc>();

  @override
  void initState() {
    super.initState();
    bloc.add(CallPlayListEvent(widget.playlistId));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: StreamBuilder<Object>(
          stream: bloc.stream,
          builder: (context, snapshot) {
            if (bloc.state is InitialPlayList) {
              return const Text('Initial');
            }
            if (bloc.state is LoadingPlayList) {
              return const Center(child: CircularProgressIndicator());
            }
            if (bloc.state is LoadingPlayList) {
              return const Center(child: CircularProgressIndicator());
            }

            if (bloc.state is SucessPlayList) {
              final list = (bloc.state as SucessPlayList).list!;

              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Text('${list[index].title}');
                  });
            }

            if (bloc.state is ErrorPlayList) {}
            return const SizedBox.shrink();
          }),
    );
  }
}
