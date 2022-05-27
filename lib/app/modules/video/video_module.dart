import 'package:flutter_modular/flutter_modular.dart';
import 'package:youtube_app/app/modules/video/views/video_view.dart';

class VideoModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/:id',
      child: (context, args) => VideoView(video: args.params['id']),
    ),
  ];
}
