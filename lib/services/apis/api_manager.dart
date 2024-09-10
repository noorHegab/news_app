import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/models/news_model.dart';
import 'package:news/models/sources_model.dart';

class ApiManager {
  static const String apiKey = "ec8fe1ff112a4f47a7aee5f5bc7786b6";

  static Future<NewsModel> getNewsByQuery(
    String id,
  ) async {
    Uri url = Uri.https("newsapi.org", "v2/everything", {
      "sources": id,
      "apiKey": apiKey,
    });

    http.Response response = await http.get(url);

    var json = jsonDecode(response.body);
    return NewsModel.fromJson(json);
  }

  static Future<SourceModel> getSourceByQuery(
    String category,
  ) async {
    Uri url = Uri.https("newsapi.org", "v2/top-headlines/sources", {
      "category": category,
      "apiKey": apiKey,
    });

    http.Response response = await http.get(url);

    var json = jsonDecode(response.body);
    return SourceModel.fromJson(json);
  }

  static Future<NewsModel> getNewsFromSearch(String query, String lang) async {
    Uri url = Uri.https("newsapi.org", "v2/everything", {
      "q": query,
      "language": lang,
      "apiKey": apiKey,
    });

    http.Response response = await http.get(url);

    var json = jsonDecode(response.body);
    return NewsModel.fromJson(json);
  }
}
