import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../utils/key.dart';

abstract class IFetchApi {
  Future apiByGet(String search, String type);
}

class HttpFetchApi implements IFetchApi {
  @override
  Future apiByGet(String search, String type) async {
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    Map<String, String> data = {
      'part': 'snippet',
      'key': API_KEY,
      'q': search,
    };

    Uri uri = Uri.https('youtube.googleapis.com', '/youtube/v3/$type', data);

    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data;
    } else {
      throw json.decode(response.body)['error']['message'];
    }
  }
}
