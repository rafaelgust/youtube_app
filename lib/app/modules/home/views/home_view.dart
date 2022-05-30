import 'package:flutter/material.dart';

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
          Center(
            child: SizedBox(width: 500, child: SearchBar()),
          ),
          RecommendedList(recommended: 'Flutter'),
        ],
      )),
    );
  }
}
