import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../bloc/recommended_list_bloc.dart';
import '../bloc/events/recommended_list_events.dart';
import '../bloc/states/recommended_list_states.dart';
import 'card_scroll_component.dart';

class RecommendedList extends StatefulWidget {
  final String? recommended;
  const RecommendedList({super.key, required this.recommended});

  @override
  State<RecommendedList> createState() => _RecommendedListState();
}

class _RecommendedListState extends State<RecommendedList> {
  final bloc = Modular.get<RecommendedListBloc>();
  late final PageController controller;
  late double? currentPage = 0.0;

  @override
  void initState() {
    super.initState();
    bloc.add(CallRecommendedListEvent('Flutter'));
    controller = PageController(initialPage: 0)..addListener(_listener);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _listener() {
    setState(() {
      currentPage = controller.page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 360,
        child: StreamBuilder<Object>(
            stream: bloc.stream,
            builder: (context, state) {
              if (bloc.state is InitialRecommendedList) {
                return const Text('Initial');
              }
              if (bloc.state is LoadingRecommendedList) {
                return const Center(child: CircularProgressIndicator());
              }
              if (bloc.state is SucessRecommendedList) {
                final list = (bloc.state as SucessRecommendedList).list!;

                return Stack(
                  children: [
                    CardScroll(
                      page: currentPage,
                      list: list,
                    ),
                    Positioned.fill(
                      bottom: 10,
                      child: PageView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: list.length,
                          controller: controller,
                          reverse: true,
                          onPageChanged: (page) {
                            debugPrint('$page');
                          },
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () => Modular.to
                                  .pushNamed('/video/${list[index].id}'),
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                  width: 240,
                                  height: 60,
                                  padding: const EdgeInsets.all(10.0),
                                  margin: const EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(3.0, 3.0),
                                        blurRadius: 5.0,
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        '${list[index].channelTitle}',
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '${list[index].description}',
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 8,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                );
              }
              if (state is ErrorRecommendedList) {}
              return const SizedBox.shrink();
            }));
  }
}
