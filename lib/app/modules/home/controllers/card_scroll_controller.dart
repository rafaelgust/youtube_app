import 'package:flutter/material.dart';

class CardScrollController extends ValueNotifier<double> {
  CardScrollController() : super(0);

  double get page => value;
  set page(newPage) => value = newPage;
}
