import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/article.dart';

class BookmarkService {
  static const String key = "bookmarks";

  Future<void> saveBookmarks(List<Article> articles) async {
    final prefs = await SharedPreferences.getInstance();

    final data = articles.map((e) => jsonEncode(e.toJson())).toList();

    await prefs.setStringList(key, data);
  }

  Future<List<Article>> loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getStringList(key);

    if (data == null) return [];

    return data.map((e) => Article.fromJson(jsonDecode(e))).toList();
  }
}
