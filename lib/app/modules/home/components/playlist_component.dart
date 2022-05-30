import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:youtube_app/app/modules/home/repositories/playlist_repository.dart';

import '../bloc/events/playlist_events.dart';
import '../bloc/playlist_bloc.dart';
import '../bloc/states/playlist_states.dart';
import '../models/playlist_model.dart';

class PlayList extends StatefulWidget {
  final String? playlistId;
  const PlayList({super.key, required this.playlistId});

  @override
  State<PlayList> createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  late final PlayListBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = PlayListBloc(Modular.get<IPlayListRepository>());
    bloc.add(CallPlayListEvent(widget.playlistId));
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(vertical: 15.0),
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

              return Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'Playlist de ${list[0].channelTitle}',
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return cardVideo(list[index]);
                        }),
                  ),
                ],
              );
            }

            if (bloc.state is ErrorPlayList) {}
            return const SizedBox.shrink();
          }),
    );
  }

  Widget cardVideo(PlayListModel item) {
    return GestureDetector(
      onTap: () => Modular.to.pushNamed('/video/${item.id}'),
      child: Column(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage('${item.thumbnails!.high.url}'),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text('${item.title}'),
          ),
        ],
      ),
    );
  }
}
