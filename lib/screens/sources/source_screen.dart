import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/news_provider.dart';

class SourceScreen extends StatelessWidget {
  const SourceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sources = ["bbc-news", "cnn", "techcrunch", "abc-news", "the-verge"];

    return Scaffold(
      appBar: AppBar(title: const Text("News Sources")),
      body: ListView.builder(
        itemCount: sources.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(sources[index]),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Provider.of<NewsProvider>(
                context,
                listen: false,
              ).fetchBySource(sources[index]);

              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}
