import 'dart:math';

import 'package:flutter/material.dart';

import '../controllers/card_scroll_controller.dart';
import '../models/recommended_list_model.dart';

class CardScroll extends StatefulWidget {
  final List<RecommendedListModel>? list;
  final CardScrollController controller;
  const CardScroll({
    super.key,
    required this.list,
    required this.controller,
  });

  @override
  State<CardScroll> createState() => _CardScrollState();
}

class _CardScrollState extends State<CardScroll> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        return Align(
          alignment: Alignment.topCenter,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: LayoutBuilder(
              builder: (context, constraints) {
                double width = constraints.maxWidth;
                double height = constraints.maxHeight;
                double safeWidth = width - 1 * 10.0;
                double safeHeight = height - 1 * 10.0;

                double heightOfPrimaryCard = safeHeight;
                double widthOfPrimaryCard = heightOfPrimaryCard * 16 / 9;

                double primaryCard = safeWidth - widthOfPrimaryCard;
                double horizontalInset = primaryCard / 2.0;

                List<Widget> cardList = [];
                for (var i = 0; i < widget.list!.length; i++) {
                  double delta = i - widget.controller.page;

                  bool hiddenCard = delta > 0;
                  double opacity = delta < -3.0 ? 0.0 : 1.0;

                  double? start = 5.0 +
                      max(
                          primaryCard -
                              horizontalInset *
                                  -delta *
                                  (hiddenCard ? 20 * 15 : 0),
                          0.0);

                  double? top = 15 - 5 * max(-delta, 0.0);

                  double? bottom = 15 * max(-delta, 0.0);

                  var cardItem = Positioned.directional(
                    top: top,
                    bottom: bottom,
                    start: start,
                    textDirection: TextDirection.rtl,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 700),
                      curve: Curves.easeIn,
                      opacity: opacity,
                      child: Container(
                        margin: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(3.0, 0.0),
                              blurRadius: 7.0,
                            )
                          ],
                        ),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    '${widget.list![i].thumbnails!.high.url}'),
                              ),
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
