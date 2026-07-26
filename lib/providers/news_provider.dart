import 'package:flutter/material.dart';

import '../models/article.dart';
import '../services/news_service.dart';

class NewsProvider extends ChangeNotifier {
  final NewsService _newsService = NewsService();

  List<Article> _articles = [];
  bool _isLoading = false;
  String _error = '';

  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchNews() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _articles = await _newsService.fetchNews();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
