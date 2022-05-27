import 'package:flutter_modular/flutter_modular.dart';

import 'bloc/search_bloc.dart';
import 'repositories/search_repository.dart';
import 'views/search_view.dart';

class SearchModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => SearchRepository(i())),
    Bind.singleton<SearchBloc>((i) => SearchBloc(i()),
        onDispose: (bloc) => bloc.close()),
  ];

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
