import 'dart:ui';

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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Playlist de',
                          textAlign: TextAlign.end,
                        ),
                        Text(
                          ' ${list[0].channelTitle}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, color: Colors.red),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return cardVideo(list[index]);
                      },
                    ),
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
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage('${item.thumbnails!.high.url}'),
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              left: 5,
              child: Container(
                width: 200,
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                  ),
                ),
                child: Text(
                  '${item.title}',
                  style: const TextStyle(
                    fontSize: 13.0,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
