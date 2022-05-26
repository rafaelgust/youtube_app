import 'package:flutter_modular/flutter_modular.dart';

import 'core/services/fetch_service.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory(((i) => HttpFetchApi())),
  ];

  @override
  final List<ModularRoute> routes = [];
}
