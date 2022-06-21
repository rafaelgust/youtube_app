import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension FormatterDateTime on String {
  String publishAt() {
    DateTime dateParsed = DateTime.parse(this);
    DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm');
    String formatted = formatter.format(dateParsed);
    return formatted;
  }
}

class InfoBarVideo extends StatelessWidget {
  final String? title, author, description, created;
  final VoidCallback goPageChannel;
  const InfoBarVideo({
    super.key,
    required this.title,
    required this.author,
    required this.description,
    required this.created,
    required this.goPageChannel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
            onPressed: goPageChannel,
            child: Text(
              '$author',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '$title',
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            '$created'.publishAt(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '$description',
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
