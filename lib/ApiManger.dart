import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/ApiConstants.dart';
import 'package:news_app/Model/SourceResponse.dart';
class ApiManger{

  static Future<SourceResponse> getSources()async{
    //https://newsapi.org/v2/top-headlines/sources?apiKey=1cf42436dcba4135a8061c103f41d049
    Uri url=Uri.https(ApiConstants.baseUrl,ApiConstants.sourceApi,
        {
        'apiKey'  :'1cf42436dcba4135a8061c103f41d049'
        }
        );
    try {
      var response = await http.get(url);
      var responseBody = response.body;  /// String
      var json = jsonDecode(responseBody);  /// json
      return SourceResponse.fromJson(json);
    }catch(e){
      throw e;
    }

  }
}