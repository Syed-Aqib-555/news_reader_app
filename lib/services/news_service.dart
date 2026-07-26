import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/article.dart';
import '../utils/constants.dart';

class NewsService {
  Future<List<Article>> fetchNews() async {
    final Uri url = Uri.parse(
      '$baseUrl/top-headlines?country=us&apiKey=$apiKey',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);

      final List<dynamic> articles = jsonData['articles'];

      return articles.map((article) => Article.fromJson(article)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}
