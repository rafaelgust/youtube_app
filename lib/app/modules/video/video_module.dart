import 'package:flutter_modular/flutter_modular.dart';
import 'package:youtube_app/app/modules/video/views/video_view.dart';

import 'bloc/video_bloc.dart';
import 'repositories/video_repository.dart';

class VideoModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => VideoRepository(i())),
    Bind.singleton<VideoBloc>((i) => VideoBloc(i()),
        onDispose: (bloc) => bloc.close()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/:id',
      child: (context, args) => VideoView(video: args.params['id']),
    ),
  ];
}
