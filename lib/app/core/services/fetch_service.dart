import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../utils/key.dart';

abstract class IFetchApi {
  Future apiByGet(String search, String type);
  Future apiPlaylist(String playlist);
}

class HttpFetchApi implements IFetchApi {
  @override
  Future apiByGet(String search, String type) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
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
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
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
}
