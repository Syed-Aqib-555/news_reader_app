import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';
import '../sources/source_screen.dart';
import '../categories/categories_screen.dart';
import '../../widgets/category_chips.dart';
import '../../providers/news_provider.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/article_card.dart';
import '../../widgets/breaking_news_card.dart';
import 'news_search_delegate.dart';
import '../settings/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<NewsProvider>(context, listen: false).fetchNews();
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        Provider.of<NewsProvider>(context, listen: false).loadMore();
      }
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
          IconButton(
            icon: const Icon(Icons.category),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CategoriesScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.newspaper),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SourceScreen()),
              );
            },
          ),

          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
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
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CategoryChips(),

                  const SizedBox(height: 10),

                  if (provider.lastUpdated != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Last Updated: ${DateFormat('MMM dd, yyyy • hh:mm a').format(provider.lastUpdated!)}",
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ),

                  const SizedBox(height: 10),

                  if (provider.articles.isNotEmpty)
                    BreakingNewsCard(article: provider.articles.first),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    child: Text(
                      "Latest News",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provider.articles.length,
                    itemBuilder: (context, index) {
                      return ArticleCard(article: provider.articles[index]);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
