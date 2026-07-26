import 'package:flutter/material.dart';

void main() {
  runApp(const NewsReaderApp());
}

class NewsReaderApp extends StatelessWidget {
  const NewsReaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News Reader',
      home: Scaffold(
        appBar: AppBar(title: const Text('News Reader'), centerTitle: true),
        body: const Center(
          child: Text(
            'Welcome to News Reader App',
            style: TextStyle(fontSize: 22),
          ),
        ),
      ),
    );
  }
}
