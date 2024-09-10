import 'package:flutter/material.dart';
import 'package:news/layout/web_view.dart';
import 'package:news/models/news_model.dart';
import 'package:news/widgets/custom_drawer.dart';

class NewScreen extends StatelessWidget {
  final Articles article;

  NewScreen({required this.article, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            article.source?.name ?? "welcome",
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(50.0),
            ),
          ),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.white,
                size: 30.0,
              ),
            ),
          ],
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
                size: 30.0,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
      ),
      drawer: customDrawer(header: "News App", context: context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              article.urlToImage ?? "",
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Image.asset(
                  'assets/images/monitor-1350918_640.webp',
                  fit: BoxFit.cover,
                );
              },
            ),
            const SizedBox(height: 16.0),
            Text(
              article.title ?? "",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              article.content ?? "",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8.0),
            Text(
              article.description ?? "",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebViewScreen(url: article.url ?? ""),
                  ),
                );
              },
              child: const Text("Open Full Article"),
            ),
          ],
        ),
      ),
    );
  }
}
