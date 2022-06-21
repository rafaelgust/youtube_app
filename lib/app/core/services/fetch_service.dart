import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../utils/key.dart';

abstract class IFetchApi {
  Future apiByGet(String search, String type);
  Future apiPlaylist(String playlist);
  Future apiVideo(String videoId);
  Future apiComments(String videoId, int maxComments);
}

class HttpFetchApi implements IFetchApi {
  Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
  };

  @override
  Future apiByGet(String search, String type) async {
    Map<String, String> data;
    data = {'part': 'snippet', 'key': API_KEY, 'q': search, 'maxResults': '20'};

    Uri uri = Uri.https('youtube.googleapis.com', '/youtube/v3/$type', data);

    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  @override
  Future apiPlaylist(String playlistId) async {
    Map<String, String> data;
    data = {'part': 'snippet', 'key': API_KEY, 'playlistId': playlistId};

    Uri uri =
        Uri.https('youtube.googleapis.com', '/youtube/v3/playlistItems', data);

    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  @override
  Future apiComments(String videoId, int maxComments) async {
    Map<String, String> data;
    data = {
      'part': 'snippet',
      'key': API_KEY,
      'id': videoId,
      'maxResults': '$maxComments'
    };

    Uri uri = Uri.https('youtube.googleapis.com', '/youtube/v3/comments', data);

    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }

  @override
  Future apiVideo(String videoId) async {
    Map<String, String> data;
    data = {
      'part': 'snippet',
      'key': API_KEY,
      'id': videoId,
    };

    Uri uri = Uri.https('youtube.googleapis.com', '/youtube/v3/videos', data);

    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }
}
