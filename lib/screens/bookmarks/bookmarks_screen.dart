import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/news_provider.dart';
import '../../widgets/article_card.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Bookmarks")),
      body: provider.bookmarks.isEmpty
          ? const Center(
              child: Text(
                "No bookmarks yet!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: provider.bookmarks.length,
              itemBuilder: (context, index) {
                return ArticleCard(article: provider.bookmarks[index]);
              },
            ),
    );
  }
}
