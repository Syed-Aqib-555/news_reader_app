import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/news_provider.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {"name": "Business", "icon": Icons.business},
      {"name": "Technology", "icon": Icons.computer},
      {"name": "Sports", "icon": Icons.sports_soccer},
      {"name": "Health", "icon": Icons.health_and_safety},
      {"name": "Science", "icon": Icons.science},
      {"name": "Entertainment", "icon": Icons.movie},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Categories")),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(categories[index]["icon"] as IconData),
            title: Text(categories[index]["name"] as String),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Provider.of<NewsProvider>(context, listen: false).fetchNews(
                category: (categories[index]["name"] as String).toLowerCase(),
              );

              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}
