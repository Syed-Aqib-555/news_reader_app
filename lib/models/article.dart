import 'package:hive/hive.dart';

part 'article.g.dart';

@HiveType(typeId: 0)
class Article extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final String imageUrl;

  @HiveField(3)
  final String articleUrl;

  @HiveField(4)
  final String source;

  @HiveField(5)
  final String publishedAt;

  Article({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.articleUrl,
    required this.source,
    required this.publishedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['urlToImage'] ?? '',
      articleUrl: json['url'] ?? '',
      source: json['source']?['name'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'url': articleUrl,
      'urlToImage': imageUrl,
      'publishedAt': publishedAt,
      'source': {'name': source},
    };
  }
}
