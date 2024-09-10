import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/components/components.dart';
import 'package:news/cubit/search_cubit.dart';
import 'package:news/cubit/search_states.dart';
import 'package:news/screens/new_screen.dart';

class NewsSearchsDelegate extends SearchDelegate<String> {
  Timer? _debounce;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
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
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit()..getSearch(query),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {
          if (state is NewsLoadingGetSearchState) {
            print('Loading search results...');
          } else if (state is NewsSuccessGetSearchState) {
            print('Search results loaded successfully.');
          } else {
            print('Search results not loaded successfully.');
          }
        },
        builder: (context, state) {
          var cubit = SearchCubit.get(context);
          if (state is NewsLoadingGetSearchState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NewsSuccessGetSearchState) {
            var articles = cubit.articles;
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                var article = articles[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        navigateTo(context, NewScreen(article: article));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: CachedNetworkImage(
                              imageUrl: article.urlToImage ?? '',
                              height: 400.0,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/images/monitor-1350918_640.webp',
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5.0),
                          Text(article.title ?? "No Title",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5.0),
                          Text(article.source?.name ?? "No Source",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 5.0),
                          Text(article.description ?? "No Description"),
                          const SizedBox(height: 5.0),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                    article.publishedAt?.substring(0, 10) ?? "")
                              ]),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(child: Text('Select a source to view news.'));
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var cubit = SearchCubit.get(context);
    // cubit.getSearch(query);
    if (query.isEmpty) {
      return const Center(child: Text("Enter a search term to get results."));
    }
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      SearchCubit.get(context).getSearch(query);
    });
    return BlocConsumer<SearchCubit, SearchStates>(
      listener: (context, state) {
        if (state is NewsLoadingGetSearchState) {
          print('Loading search results...');
        } else if (state is NewsSuccessGetSearchState) {
          print('Search results loaded successfully.');
        } else {
          print('Search results not loaded successfully.');
        }
      },
      builder: (context, state) {
        var cubit = SearchCubit.get(context);
        if (state is NewsLoadingGetSearchState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is NewsSuccessGetSearchState) {
          var articles = cubit.articles;
          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              var article = articles[index];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      navigateTo(context, NewScreen(article: article));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: CachedNetworkImage(
                            imageUrl: article.urlToImage ?? '',
                            height: 400.0,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Image.asset(
                              'assets/images/monitor-1350918_640.webp',
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(article.title ?? "No Title",
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5.0),
                        Text(article.source?.name ?? "No Source",
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5.0),
                        Text(article.description ?? "No Description"),
                        const SizedBox(height: 5.0),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(article.publishedAt?.substring(0, 10) ?? "")
                            ]),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
        return const Center(child: Text('Select a source to view news.'));
      },
    );
  }

  Widget buildAppBarActions(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.search),
      onPressed: () {
        showSearch(
          context: context,
          delegate: NewsSearchsDelegate(),
        );
      },
    );
  }
}
