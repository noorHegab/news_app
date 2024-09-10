import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/components/components.dart';
import 'package:news/cubit/cubit.dart';
import 'package:news/cubit/states.dart';
import 'package:news/screens/new_screen.dart';

class InitialScreen extends StatelessWidget {
  final String category;

  InitialScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (_) => NewsCubit()..getSources(category),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {
          if (state is NewsErrorGetSourcesState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.error}')),
            );
          }
        },
        builder: (context, state) {
          var cubit = NewsCubit.get(context);

          if (state is NewsLoadingGetSourcesState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NewsErrorGetSourcesState) {
            return const Center(
              child: Text("error"),
            );
          } else {
            var sources = cubit.sources;

            return Column(
              children: [
                DefaultTabController(
                  length: sources.length,
                  child: Column(
                    children: [
                      TabBar(
                        onTap: (value) {
                          print("Tab pressed: $value");
                          cubit.changeTab(value);
                        },
                        isScrollable: true,
                        tabs: sources.map((e) {
                          return Tab(
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: cubit.selectedIndex == sources.indexOf(e)
                                    ? Colors.green
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.green),
                              ),
                              child: Text(
                                e.name ?? '',
                                style: TextStyle(
                                  color:
                                      cubit.selectedIndex == sources.indexOf(e)
                                          ? Colors.white
                                          : Colors.green,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                Expanded(
                  child: BlocBuilder<NewsCubit, NewsStates>(
                    builder: (context, state) {
                      if (state is NewsLoadingGetArticlesState) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is NewsSuccessGetArticlesState) {
                        var articles = cubit.articles;
                        print("Articles length: ${articles.length}");
                        return ListView.builder(
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            var article = articles[index];
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    navigateTo(
                                        context, NewScreen(article: article));
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(18),
                                        child: CachedNetworkImage(
                                          imageUrl: article.urlToImage ?? '',
                                          height: screenHeight * 0.3,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              const Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                            'assets/images/monitor-1350918_640.webp',
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 5.0),
                                      Text(article.title ?? "No Title",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 5.0),
                                      Text(article.source?.name ?? "No Source",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 5.0),
                                      Text(article.description ??
                                          "No Description"),
                                      const SizedBox(height: 5.0),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(article.publishedAt
                                                  ?.substring(0, 10) ??
                                              "")
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return const Center(
                          child: Text('Select a source to view news.'));
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
