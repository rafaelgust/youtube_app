import 'package:flutter_modular/flutter_modular.dart';

import 'views/channel_view.dart';

class ChannelModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/:id',
      child: (context, args) => ChannelView(channel: args.params['id']),
    ),
  ];
}
