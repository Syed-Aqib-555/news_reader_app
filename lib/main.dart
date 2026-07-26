import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/navigation/main_navigation.dart';
import 'providers/news_provider.dart';
import 'providers/theme_provider.dart';
//import 'screens/home/home_screen.dart';

void main() {
  runApp(const NewsReaderApp());
}

class NewsReaderApp extends StatelessWidget {
  const NewsReaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'News Reader',

            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              useMaterial3: true,
            ),

            darkTheme: ThemeData(
              brightness: Brightness.dark,
              useMaterial3: true,
            ),

            themeMode: themeProvider.themeMode,

            home: const MainNavigation(),
          );
        },
      ),
    );
  }
}
