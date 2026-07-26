import 'package:flutter/material.dart';

import '../models/article.dart';
import '../services/news_service.dart';

class NewsProvider extends ChangeNotifier {
  final NewsService _service = NewsService();

  List<Article> _articles = [];
  bool _isLoading = false;
  String _error = '';

  List<Article> get articles => _articles;
  bool get isLoading => _isLoading;
  String get error => _error;

  final List<Article> _bookmarks = [];

  List<Article> get bookmarks => _bookmarks;

  bool isBookmarked(Article article) {
    return _bookmarks.any((a) => a.articleUrl == article.articleUrl);
  }

  void toggleBookmark(Article article) {
    if (isBookmarked(article)) {
      _bookmarks.removeWhere((a) => a.articleUrl == article.articleUrl);
    } else {
      _bookmarks.add(article);
    }

    notifyListeners();
  }

  Future<void> fetchNews({
    String category = 'general',
    String country = 'us',
  }) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _articles = await _service.fetchTopHeadlines(
        category: category,
        country: country,
      );
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> search(String query) async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _articles = await _service.searchNews(query);
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
