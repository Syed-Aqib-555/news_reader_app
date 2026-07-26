import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/news_provider.dart';
import '../../widgets/article_card.dart';
import 'news_search_delegate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<NewsProvider>(context, listen: false).fetchNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NewsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("News Reader"),
        centerTitle: true,

        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: NewsSearchDelegate());
            },
          ),
        ],
      ),

      body: Builder(
        builder: (_) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error.isNotEmpty) {
            return Center(child: Text(provider.error));
          }

          return ListView.builder(
            itemCount: provider.articles.length,
            itemBuilder: (context, index) {
              return ArticleCard(article: provider.articles[index]);
            },
          );
        },
      ),
    );
  }
}
