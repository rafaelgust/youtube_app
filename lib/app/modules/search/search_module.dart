import 'package:flutter_modular/flutter_modular.dart';

import 'views/search_view.dart';

class SearchModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/:search',
      child: (context, args) => SearchView(
        search: args.params['search'],
      ),
    ),
  ];
}
