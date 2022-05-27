import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/search_model.dart';

extension FormatterDateTime on String {
  String ddMMyyyy() {
    DateTime dateParsed = DateTime.parse(this);
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    String formatted = formatter.format(dateParsed);
    return formatted;
  }
}

class ItemSearch extends StatelessWidget {
  final SearchModel? item;
  final VoidCallback goPageVideo;
  final VoidCallback goPageChannel;
  const ItemSearch(
    this.item, {
    super.key,
    required this.goPageVideo,
    required this.goPageChannel,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: 380,
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(3, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () => goPageVideo(),
              child: Text(
                '${item?.title}',
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () => goPageVideo(),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage('${item?.thumbnails?.high.url}'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${item?.description}'),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () => goPageChannel(),
                    child: Text(
                      '${item?.channelTitle}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Text('${item?.publishedAt}'.ddMMyyyy()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
