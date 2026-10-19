import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Обложка книги с закруглением и заглушкой на время загрузки / при ошибке.
/// Размер задаётся родителем (SizedBox, AspectRatio и т.д.).
class BookCover extends StatelessWidget {
  const BookCover({super.key, required this.url, this.radius = 12});

  final String url;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.network(
        url,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) =>
            progress == null ? child : const _CoverPlaceholder(),
        errorBuilder: (context, error, stackTrace) =>
            const _CoverPlaceholder(),
      ),
    );
  }
}

class _CoverPlaceholder extends StatelessWidget {
  const _CoverPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.chip,
      alignment: Alignment.center,
      child: const Icon(Icons.menu_book_rounded, color: AppColors.accent),
    );
  }
}
