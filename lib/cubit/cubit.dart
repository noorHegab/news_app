import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:news/cubit/states.dart';
import 'package:news/models/news_model.dart';
import 'package:news/models/sources_model.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  static const String apiKey = "8ad760e77e5d498c8415de59730ad7cd";

  List<Sources> sources = [];
  List<Articles> articles = [];
  int selectedIndex = 0;
  NewsModel? searchResults;

  Future<void> getSources(String category) async {
    emit(NewsLoadingGetSourcesState());
    try {
      Uri url = Uri.https("newsapi.org", "v2/top-headlines/sources", {
        "category": category,
        "apiKey": apiKey,
      });

      http.Response response = await http.get(url);

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        SourceModel sourceModel = SourceModel.fromJson(json);
        sources = sourceModel.sources ?? [];
        emit(NewsSuccessGetSourcesState());
        if (sources.isNotEmpty) {
          await getArticles(sources[0].id ?? "");
        }
      } else {
        emit(NewsErrorGetSourcesState(
            "Failed to load sources: ${response.statusCode}"));
      }
    } catch (error) {
      emit(NewsErrorGetSourcesState(
          "Failed to load sources: ${error.toString()}"));
    }
  }

  Future<void> getArticles(String sourceId) async {
    emit(NewsLoadingGetArticlesState());
    try {
      Uri url = Uri.https("newsapi.org", "v2/everything", {
        "sources": sourceId,
        "apiKey": apiKey,
      });

      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        NewsModel newsModel = NewsModel.fromJson(json);
        articles = newsModel.articles ?? [];
        emit(NewsSuccessGetArticlesState());
      } else {
        emit(NewsErrorGetArticlesState(
            "Failed to load articles: ${response.statusCode}"));
      }
    } catch (error) {
      emit(NewsErrorGetArticlesState(
          "Failed to load articles: ${error.toString()}"));
    }
  }

  // Future<void> getSearch(String query) async {
  //   emit(NewsLoadingGetArticlesState());
  //   try {
  //     Uri url = Uri.https("newsapi.org", "v2/everything", {
  //       "q": query,
  //       "apiKey": apiKey,
  //     });
  //
  //     http.Response response = await http.get(url);
  //
  //     if (response.statusCode == 200) {
  //       var json = jsonDecode(response.body);
  //       NewsModel newsModel = NewsModel.fromJson(json);
  //       articles = newsModel.articles ?? [];
  //       emit(NewsSuccessGetArticlesState());
  //     } else {
  //       emit(NewsErrorGetArticlesState(
  //           "Failed to load articles: ${response.statusCode}"));
  //     }
  //   } catch (error) {
  //     emit(NewsErrorGetArticlesState(
  //         "Failed to load articles: ${error.toString()}"));
  //   }
  // }

  Future<void> changeTab(int index) async {
    if (index == selectedIndex) return;
    selectedIndex = index;
    emit(NewsLoadingGetArticlesState());
    try {
      Uri url = Uri.https("newsapi.org", "v2/everything", {
        "sources": sources[index].id ?? "",
        "apiKey": apiKey,
      });

      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        NewsModel newsModel = NewsModel.fromJson(json);
        articles = newsModel.articles ?? [];
        emit(NewsSuccessGetArticlesState());
      } else {
        emit(NewsErrorGetArticlesState(
            "Failed to load articles: ${response.statusCode}"));
      }
    } catch (error) {
      emit(NewsErrorGetArticlesState(
          "Failed to change tab: ${error.toString()}"));
    }
  }
}
