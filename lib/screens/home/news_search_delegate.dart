import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/news_provider.dart';
import '../../widgets/article_card.dart';

class NewsSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final provider = Provider.of<NewsProvider>(context, listen: false);

    provider.search(query);

    return Consumer<NewsProvider>(
      builder: (context, value, child) {
        if (value.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: value.articles.length,
          itemBuilder: (_, index) {
            return ArticleCard(article: value.articles[index]);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(child: Text("Search News"));
  }
}
