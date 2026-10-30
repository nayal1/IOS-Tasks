
import 'package:flutter/material.dart';

class Product {
  final int id;
  final String title;
  final String category;
  final double rating;
  final double price;
  final IconData icon;

  const Product({
    required this.id,
    required this.title,
    required this.category,
    required this.rating,
    required this.price,
    required this.icon,
  });
}

// Initial catalog data
final List<Product> initialProducts = [
  const Product(
    id: 1,
    title: 'The Great Gatsby',
    category: 'Classic',
    rating: 4.8,
    price: 4500,
    icon: Icons.menu_book,
  ),
  const Product(
    id: 2,
    title: 'Pride and Prejudice',
    category: 'Romance',
    rating: 4.9,
    price: 5200,
    icon: Icons.favorite_border,
  ),
  const Product(
    id: 3,
    title: 'The Silent Patient',
    category: 'Thriller',
    rating: 4.7,
    price: 6100,
    icon: Icons.psychology,
  ),
  const Product(
    id: 4,
    title: 'Little Women',
    category: 'Classic',
    rating: 4.6,
    price: 4800,
    icon: Icons.auto_stories,
  ),
  const Product(
    id: 5,
    title: 'Atomic Habits',
    category: 'Self-help',
    rating: 4.9,
    price: 5900,
    icon: Icons.lightbulb_outline,
  ),
  const Product(
    id: 6,
    title: 'The Midnight Library',
    category: 'Fantasy',
    rating: 4.8,
    price: 5500,
    icon: Icons.nightlight_round,
  ),
  const Product(
    id: 7,
    title: 'It Ends with Us',
    category: 'Romance',
    rating: 4.5,
    price: 4900,
    icon: Icons.book,
  ),
  const Product(
    id: 8,
    title: 'The Psychology of Money',
    category: 'Psychology',
    rating: 4.7,
    price: 6200,
    icon: Icons.account_balance,
  ),
];
