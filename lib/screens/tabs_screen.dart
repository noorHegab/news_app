import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/components/components.dart';
import 'package:news/models/news_model.dart';
import 'package:news/models/sources_model.dart';
import 'package:news/screens/new_screen.dart';
import 'package:news/services/apis/api_manager.dart';

class TabsScreen extends StatefulWidget {
  final String category;

  TabsScreen({required this.category, super.key});

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiManager.getSourceByQuery(
        widget.category,
      ),
      builder: (context, snapshot) {
        List<Sources>? sources = snapshot.data?.sources ?? [];

        return Column(
          children: [
            DefaultTabController(
              length: sources.length,
              child: TabBar(
                onTap: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
                indicatorColor: Colors.transparent,
                labelPadding: const EdgeInsets.all(3),
                isScrollable: true,
                tabs: sources.map((e) {
                  return Tab(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: selectedIndex == sources.indexOf(e)
                            ? Colors.green
                            : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.green),
                      ),
                      child: Text(
                        e.name ?? "",
                        style: TextStyle(
                          color: selectedIndex == sources.indexOf(e)
                              ? Colors.white
                              : Colors.green,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            if (sources.isNotEmpty)
              Expanded(
                child: FutureBuilder(
                  future: ApiManager.getNewsByQuery(
                    sources[selectedIndex].id ?? "",
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else if (snapshot.data?.articles == null ||
                        snapshot.data!.articles!.isEmpty) {
                      return const Center(child: Text("No articles available"));
                    }

                    List<Articles> articles = snapshot.data?.articles ?? [];
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(18),
                                    child: CachedNetworkImage(
                                      imageUrl: article.urlToImage ?? '',
                                      height: 400.0,
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
                                  Text(article.description ?? "No Description"),
                                  const SizedBox(height: 5.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
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
                  },
                ),
              ),
            if (sources.isEmpty)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        );
      },
    );
  }
}
