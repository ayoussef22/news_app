import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/API/ApiConstants.dart';
import 'package:news_app/Model/NewsResponse.dart';
import 'package:news_app/Model/SourceResponse.dart';

class ApiManger {
  static Future<SourceResponse> getSources(String categoryId) async {
    //https://newsapi.org/v2/top-headlines/sources?apiKey=1cf42436dcba4135a8061c103f41d049
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.sourceApi,
        {'apiKey': '1cf42436dcba4135a8061c103f41d049', 'category': categoryId});
    try {
      var response = await http.get(url);
      var responseBody = response.body;

      /// String
      var json = jsonDecode(responseBody);

      /// json
      return SourceResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<NewsResponse> getNewsFromSourcesId(
      {required String sourceId, int page = 1}) async {
    //https://newsapi.org/v2/everything?q=bitcoin&apiKey=1cf42436dcba4135a8061c103f41d049
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.newsApi, {
      'apiKey': '1cf42436dcba4135a8061c103f41d049',
      'sources': sourceId,
      'pageSize': '20',
      'page': '$page',
    });
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return NewsResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }

  static Future<NewsResponse> searchResult(String query) async {
    //https://newsapi.org/v2/everything?q=bitcoin&apiKey=1cf42436dcba4135a8061c103f41d049
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.newsApi,
        {'apiKey': '1cf42436dcba4135a8061c103f41d049', 'q': query});
    try {
      var response = await http.get(url);
      var responseBody = response.body;
      var json = jsonDecode(responseBody);
      return NewsResponse.fromJson(json);
    } catch (e) {
      throw e;
    }
  }
}
