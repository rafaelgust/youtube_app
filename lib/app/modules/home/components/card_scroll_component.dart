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
  final double verticalInset = 15.0;
  final double cardAspectRadio = 12.0 / 10.0;
  late double widgetAspectRadio;

  @override
  void initState() {
    super.initState();
    widgetAspectRadio = cardAspectRadio * 1.2;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.controller,
        builder: (context, child) {
          return AspectRatio(
            aspectRatio: widgetAspectRadio,
            child: LayoutBuilder(
              builder: (context, constraints) {
                double width = constraints.maxWidth;
                double height = constraints.maxHeight;
                double safeWidth = width - 2 * padding;
                double safeHeight = height - 2 * padding;

                double heightOfPrimaryCard = safeHeight;
                double widthOfPrimaryCard =
                    heightOfPrimaryCard * cardAspectRadio;

                double primaryCardOfLeft = safeWidth - widthOfPrimaryCard;
                double horizontalInset = primaryCardOfLeft / 2;

                List<Widget> cardList = [];
                for (var i = 0; i < widget.list!.length; i++) {
                  double delta = i - widget.controller.page;
                  bool isOnRight = delta > 0;

                  double? start = padding +
                      max(
                          primaryCardOfLeft -
                              horizontalInset * -delta * (isOnRight ? 15 : 1),
                          0.0);

                  var cardItem = Positioned.directional(
                    top: padding + verticalInset * max(-delta, 0.0),
                    bottom: padding + verticalInset * max(-delta, 0.0),
                    start: start,
                    textDirection: TextDirection.rtl,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(3.0, 6.0),
                            blurRadius: 10.0,
                          )
                        ],
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              '${widget.list![i].thumbnails!.high.url}'),
                        ),
                      ),
                      child: AspectRatio(
                        aspectRatio: cardAspectRadio,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                padding: const EdgeInsets.all(5.0),
                                margin: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Text(
                                  '${widget.list![i].title}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
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
          );
        });
  }
}
