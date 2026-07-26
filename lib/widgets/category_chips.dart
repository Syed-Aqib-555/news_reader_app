import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/news_provider.dart';

class CategoryChips extends StatelessWidget {
  const CategoryChips({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      "general",
      "business",
      "technology",
      "sports",
      "health",
      "science",
      "entertainment",
    ];

    return SizedBox(
      height: 55,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ActionChip(
              label: Text(categories[index].toUpperCase()),
              onPressed: () {
                Provider.of<NewsProvider>(
                  context,
                  listen: false,
                ).fetchNews(category: categories[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
