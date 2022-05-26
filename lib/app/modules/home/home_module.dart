import 'package:flutter_modular/flutter_modular.dart';

import 'views/home_view.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (context, args) => const HomeView()),
  ];
}
