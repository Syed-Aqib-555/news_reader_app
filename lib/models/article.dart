class Article {
  final String title;
  final String description;
  final String imageUrl;
  final String articleUrl;
  final String source;
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
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? 'No Description',
      imageUrl: json['urlToImage'] ?? '',
      articleUrl: json['url'] ?? '',
      source: json['source']?['name'] ?? 'Unknown',
      publishedAt: json['publishedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'urlToImage': imageUrl,
      'url': articleUrl,
      'source': {'name': source},
      'publishedAt': publishedAt,
    };
  }
}
