import 'dart:convert';

class Thumbnails {
  final Thumbnail small;
  final Thumbnail medium;
  final Thumbnail high;

  Thumbnails({
    required this.small,
    required this.medium,
    required this.high,
  });

  factory Thumbnails.fromMap(Map<String, dynamic> map) {
    return Thumbnails(
      small: Thumbnail.fromMap(map['default']),
      medium: Thumbnail.fromMap(map['medium']),
      high: Thumbnail.fromMap(map['high']),
    );
  }

  factory Thumbnails.fromJson(String source) =>
      Thumbnails.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'default': small.toMap(),
      'medium': medium.toMap(),
      'high': high.toMap(),
    };
  }

  String toJson() => json.encode(toMap());
}

class Thumbnail {
  final String? url;
  final int? width;
  final int? height;
  Thumbnail({
    required this.url,
    required this.width,
    required this.height,
  });

  factory Thumbnail.fromMap(Map<String, dynamic> map) {
    return Thumbnail(
      url: map['url'],
      width: map['width'],
      height: map['height'],
    );
  }

  factory Thumbnail.fromJson(String source) =>
      Thumbnail.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'width': width,
      'height': height,
    };
  }

  String toJson() => json.encode(toMap());
}
