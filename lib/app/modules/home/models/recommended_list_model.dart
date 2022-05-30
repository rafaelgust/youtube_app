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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'thumbnails': thumbnails?.toMap(),
      'channelTitle': channelTitle,
    };
  }

  factory RecommendedListModel.fromMap(Map<String, dynamic> map) {
    return RecommendedListModel(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      thumbnails: map['thumbnails'] != null
          ? Thumbnails.fromMap(map['thumbnails'] as Map<String, dynamic>)
          : null,
      channelTitle:
          map['channelTitle'] != null ? map['channelTitle'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory RecommendedListModel.fromJson(String source) =>
      RecommendedListModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
