import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/article.dart';
import '../utils/constants.dart';

class NewsService {
  Future<List<Article>> fetchTopHeadlines() async {
    final response = await http.get(
      Uri.parse('$baseUrl/top-headlines?country=us&apiKey=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return (data['articles'] as List)
          .map((e) => Article.fromJson(e))
          .toList();
    }

    throw Exception('Failed to load news');
  }

  Future<List<Article>> searchNews(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl/everything?q=$query&apiKey=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return (data['articles'] as List)
          .map((e) => Article.fromJson(e))
          .toList();
    }

    throw Exception('Failed to search news');
  }
}
