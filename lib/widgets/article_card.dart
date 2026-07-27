import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import '../models/article.dart';
import '../providers/news_provider.dart';
import '../screens/details/article_detail_screen.dart';

class ArticleCard extends StatelessWidget {
  final Article article;

  const ArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ArticleDetailScreen(article: article),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        elevation: 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.imageUrl.isNotEmpty &&
                article.imageUrl.startsWith("http"))
              CachedNetworkImage(
                imageUrl: article.imageUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey,
                  child: const Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      article.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Consumer<NewsProvider>(
                    builder: (context, provider, child) {
                      return IconButton(
                        icon: Icon(
                          provider.isBookmarked(article)
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          color: Colors.blue,
                        ),
                        onPressed: () async {
                          final wasBookmarked = provider.isBookmarked(article);

                          await provider.toggleBookmark(article);

                          if (!context.mounted) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                wasBookmarked
                                    ? "Removed from Bookmarks"
                                    : "Added to Bookmarks",
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(article.description),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 14,
                    child: Icon(Icons.public, size: 16),
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: Text(
                      article.source,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  Text(
                    article.publishedAt,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
