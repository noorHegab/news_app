import 'package:flutter/material.dart';
import 'package:news/components/components.dart';
import 'package:news/models/news_model.dart';
import 'package:news/provider/notifier.dart';
import 'package:news/screens/new_screen.dart';
import 'package:news/services/apis/api_manager.dart';
import 'package:provider/provider.dart';

class NewsSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // حذف النص المدخل
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, ''); // العودة إلى الشاشة السابقة
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    // استدعاء API والبحث باستخدام الـ query
    return FutureBuilder<NewsModel?>(
      future: ApiManager.getNewsFromSearch(
        query,
        themeNotifier.lang,
      ), // البحث باستخدام query
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.articles!.isEmpty) {
          return const Center(child: Text('No results found.'));
        } else {
          final articles = snapshot.data!.articles;
          return ListView.builder(
            itemCount: articles!.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return InkWell(
                onTap: () {
                  navigateTo(
                      context,
                      NewScreen(
                        article: article,
                      ));
                },
                child: ListTile(
                  title: Text(article.title ?? "No Title"),
                  subtitle: Text(article.description ?? "No Description"),
                  leading: article.urlToImage != null
                      ? Image.network(article.urlToImage!,
                          width: 100, fit: BoxFit.cover)
                      : null,
                ),
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    if (query.isEmpty) {
      return const Center(child: Text("Enter a search term to get results."));
    }

    return FutureBuilder<NewsModel?>(
      future: ApiManager.getNewsFromSearch(
          query, themeNotifier.lang), // البحث باستخدام query
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.articles!.isEmpty) {
          return const Center(child: Text('No results found.'));
        } else {
          final articles = snapshot.data!.articles;
          return ListView.builder(
            itemCount: articles!.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return InkWell(
                onTap: () {
                  navigateTo(
                      context,
                      NewScreen(
                        article: article,
                      ));
                },
                child: ListTile(
                  title: Text(article.title ?? "No Title"),
                  subtitle: Text(article.description ?? "No Description"),
                  leading: article.urlToImage != null
                      ? Image.network(article.urlToImage!,
                          width: 100, fit: BoxFit.cover)
                      : null,
                ),
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget buildAppBarActions(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.search),
      onPressed: () {
        showSearch(
          context: context,
          delegate: NewsSearchDelegate(),
        );
      },
    );
  }
}
