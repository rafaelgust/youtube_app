import 'package:flutter/material.dart';

import '../components/playlist_component.dart';
import '../components/recommended_list_component.dart';
import '../components/search_component.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        physics: const BouncingScrollPhysics(),
        children: const [
          Center(child: SizedBox(width: 500, child: SearchBar())),
          SizedBox(width: 500, child: RecommendedList(recommended: 'Flutter')),
          PlayList(playlistId: 'PLCXgRxZT4r82Vqb8EdJNDeBTQn-mbOMMY'),
          PlayList(playlistId: 'PLK3BZE3cGU6h2nIXa0yZHHX_qWtsfwdnc'),
        ],
      )),
    );
  }
}
