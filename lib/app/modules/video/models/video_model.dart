class VideoModel {
  VideoModel({
    required this.publishedAt,
    required this.channelId,
    required this.title,
    required this.description,
    required this.channelTitle,
    required this.categoryId,
    required this.liveBroadcastContent,
    required this.localized,
  });
  late final String publishedAt;
  late final String channelId;
  late final String title;
  late final String description;
  late final String channelTitle;
  late final String categoryId;
  late final String liveBroadcastContent;
  late final Localized localized;

  VideoModel.fromJson(Map<String, dynamic> json) {
    publishedAt = json["snippet"]['publishedAt'];
    channelId = json["snippet"]['channelId'];
    title = json["snippet"]['title'];
    description = json["snippet"]['description'];
    channelTitle = json["snippet"]['channelTitle'];
    categoryId = json["snippet"]['categoryId'];
    liveBroadcastContent = json["snippet"]['liveBroadcastContent'];
    localized = Localized.fromJson(json["snippet"]['localized']);
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['publishedAt'] = publishedAt;
    data['channelId'] = channelId;
    data['title'] = title;
    data['description'] = description;
    data['channelTitle'] = channelTitle;
    data['categoryId'] = categoryId;
    data['liveBroadcastContent'] = liveBroadcastContent;
    data['localized'] = localized.toJson();
    return data;
  }
}

class Localized {
  Localized({
    required this.title,
    required this.description,
  });
  late final String title;
  late final String description;

  Localized.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    return data;
  }
}
