import '../../../core/models/thumbnail_model.dart';

class PlayListModel {
  String? id;
  String? title;
  String? channelTitle;
  String? channelId;
  String? publishedAt;
  Thumbnails? thumbnails;

  PlayListModel({
    this.id,
    this.title,
    this.channelId,
    this.channelTitle,
    this.publishedAt,
    this.thumbnails,
  });

  PlayListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['snippet']['title'];
    channelTitle = json['snippet']['channelTitle'];
    channelId = json['snippet']['channelId'];
    publishedAt = json['snippet']['publishedAt'];
    thumbnails = Thumbnails.fromMap(json['snippet']['thumbnails']);
  }
}
