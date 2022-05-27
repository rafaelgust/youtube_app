import '../../../core/models/thumbnail_model.dart';

class SearchModel {
  String? id;
  String? channelId;
  String? channelTitle;
  String? publishedAt;
  String? title;
  String? description;
  Thumbnails? thumbnails;
  String? liveBroadcastContent;
  String? publishTime;

  SearchModel({
    this.id,
    this.title,
    this.publishedAt,
    this.channelId,
    this.description,
    this.thumbnails,
    this.channelTitle,
    this.liveBroadcastContent,
    this.publishTime,
  });

  SearchModel.fromJson(Map<String, dynamic> json) {
    id = json['id']['videoId'];
    title = json['snippet']['title'];
    publishedAt = json['snippet']['publishedAt'];
    channelId = json['snippet']['channelId'];
    description = json['snippet']['description'];
    thumbnails = Thumbnails.fromMap(json['snippet']['thumbnails']);
    channelTitle = json['snippet']['channelTitle'];
    liveBroadcastContent = json['snippet']['liveBroadcastContent'];
    publishTime = json['snippet']['publishTime'];
  }
}
