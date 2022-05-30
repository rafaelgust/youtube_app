import 'dart:math';

import 'package:flutter/material.dart';

import '../controllers/card_scroll_controller.dart';
import '../models/recommended_list_model.dart';

class CardScroll extends StatefulWidget {
  final List<RecommendedListModel>? list;
  final CardScrollController controller;
  const CardScroll({super.key, required this.list, required this.controller});

  @override
  State<CardScroll> createState() => _CardScrollState();
}

class _CardScrollState extends State<CardScroll> {
  final double padding = 15.0;
  final double cardAspectRadio = 1.2;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        return Align(
          alignment: Alignment.topCenter,
          child: AspectRatio(
            aspectRatio: 4 / 3,
            child: LayoutBuilder(
              builder: (context, constraints) {
                double width = constraints.maxWidth;
                double height = constraints.maxHeight;
                double safeWidth = width - 1 * padding;
                double safeHeight = height - 1 * padding;

                double heightOfPrimaryCard = safeHeight;
                double widthOfPrimaryCard = heightOfPrimaryCard * 4 / 3;

                double primaryCard = safeWidth - widthOfPrimaryCard;
                double horizontalInset = primaryCard / 2.0;

                List<Widget> cardList = [];
                for (var i = 0; i < widget.list!.length; i++) {
                  double delta = i - widget.controller.page;
                  bool isOnBack = delta > 0;

                  double? start = padding +
                      max(
                          primaryCard -
                              horizontalInset *
                                  -delta *
                                  (isOnBack ? 20 * 8 : 0),
                          0.0);

                  double? top = padding - 5 * max(-delta, 0.0);

                  double? bottom = padding * max(-delta, 0.0);

                  var cardItem = Positioned.directional(
                    top: top,
                    bottom: bottom,
                    start: start,
                    textDirection: TextDirection.rtl,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: AspectRatio(
                        aspectRatio: cardAspectRadio,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(3.0, 3.0),
                                blurRadius: 5.0,
                              )
                            ],
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  '${widget.list![i].thumbnails!.high.url}'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                  cardList.add(cardItem);
                }

                return Stack(
                  children: cardList,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
