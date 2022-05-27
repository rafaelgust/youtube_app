import 'package:flutter_modular/flutter_modular.dart';

import 'core/services/fetch_service.dart';

import 'modules/channel/channel_module.dart';
import 'modules/home/home_module.dart';
import 'modules/search/search_module.dart';
import 'modules/video/video_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory(((i) => HttpFetchApi())),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: HomeModule()),
    ModuleRoute('/search', module: SearchModule()),
    ModuleRoute('/channel', module: ChannelModule()),
    ModuleRoute('/video', module: VideoModule()),
  ];
}
