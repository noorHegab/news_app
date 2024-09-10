import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:news/cubit/search_states.dart';
import 'package:news/models/news_model.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of<SearchCubit>(context);

  static const String apiKey = "8ad760e77e5d498c8415de59730ad7cd";
  List<Articles> articles = [];
  Future<void> getSearch(String query) async {
    emit(NewsLoadingGetSearchState());

    if (query.isEmpty) {
      emit(SearchInitialState());
      return;
    }

    try {
      final Uri url = Uri.https("newsapi.org", "v2/everything", {
        "q": query,
        "apiKey": apiKey,
      });

      final http.Response response = await http.get(url);

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = jsonDecode(response.body);

        if (json['articles'] != null && json['articles'].isNotEmpty) {
          final NewsModel newsModel = NewsModel.fromJson(json);
          articles = newsModel.articles ?? [];
          emit(NewsSuccessGetSearchState());
        } else {
          emit(NewsErrorGetSearchState("No articles found for '$query'."));
        }
      } else {
        emit(NewsErrorGetSearchState(
            "Error: ${response.statusCode}. Unable to fetch data."));
      }
    } catch (error) {
      emit(NewsErrorGetSearchState(
          "Failed to load articles: ${error.toString()}"));
    }
  }
}
