
import 'package:flutter/material.dart';
import 'screens/catalog_screen.dart';

void main() {
  runApp(const SmartBookCatalogApp());
}

class SmartBookCatalogApp extends StatelessWidget {
  const SmartBookCatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Book Catalog',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF6F0E8),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF795548),
        ),
      ),
      home: const CatalogScreen(),
    );
  }
}
