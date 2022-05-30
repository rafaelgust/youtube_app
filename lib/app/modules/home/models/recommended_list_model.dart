// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../../core/models/thumbnail_model.dart';

class RecommendedListModel {
  String? id;
  String? title;
  String? description;
  Thumbnails? thumbnails;
  String? channelTitle;

  RecommendedListModel({
    this.id,
    this.title,
    this.description,
    this.thumbnails,
    this.channelTitle,
  });

  RecommendedListModel.fromJson(Map<String, dynamic> json) {
    id = json['id']['videoId'];
    title = json['snippet']['title'];
    description = json['snippet']['description'];
    thumbnails = Thumbnails.fromMap(json['snippet']['thumbnails']);
    channelTitle = json['snippet']['channelTitle'];
  }
}
