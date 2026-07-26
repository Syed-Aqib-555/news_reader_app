import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/news_provider.dart';
import '../../providers/theme_provider.dart';
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
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return IconButton(
                icon: Icon(
                  themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                ),
                onPressed: () {
                  themeProvider.toggleTheme();
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: NewsSearchDelegate());
            },
          ),

          PopupMenuButton<String>(
            icon: const Icon(Icons.public),
            onSelected: (value) {
              Provider.of<NewsProvider>(
                context,
                listen: false,
              ).fetchNews(country: value);
            },
            itemBuilder: (context) => const [
              PopupMenuItem(value: "us", child: Text("🇺🇸 United States")),
              PopupMenuItem(value: "gb", child: Text("🇬🇧 United Kingdom")),
              PopupMenuItem(value: "pk", child: Text("🇵🇰 Pakistan")),
              PopupMenuItem(value: "in", child: Text("🇮🇳 India")),
              PopupMenuItem(value: "ca", child: Text("🇨🇦 Canada")),
            ],
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

          return RefreshIndicator(
            onRefresh: () async {
              await provider.fetchNews();
            },
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: provider.articles.length,
              itemBuilder: (context, index) {
                return ArticleCard(article: provider.articles[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
