import 'package:flutter_modular/flutter_modular.dart';
import 'package:youtube_app/app/modules/home/bloc/recommended_list_bloc.dart';
import 'package:youtube_app/app/modules/home/repositories/recommended_list_repository.dart';

import 'views/home_view.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory((i) => RecommendedListRepository(i())),
    Bind.singleton<RecommendedListBloc>((i) => RecommendedListBloc(i()),
        onDispose: (bloc) => bloc.close()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (context, args) => const HomeView()),
  ];
}
