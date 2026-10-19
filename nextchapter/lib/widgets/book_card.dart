import 'package:flutter/material.dart';

import '../models/book.dart';
import '../theme/app_theme.dart';
import 'book_cover.dart';

/// Горизонтальная карточка: обложка слева, информация и кнопка справа.
class BookCard extends StatelessWidget {
  const BookCard({super.key, required this.book, required this.onTap});

  final Book book;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Card(
      margin: EdgeInsets.zero,
      color: AppColors.surface,
      elevation: 2,
      shadowColor: AppColors.shadow,
      shape: AppTheme.cardShape,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 84,
                height: 120,
                child: BookCover(url: book.coverUrl),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      book.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: text.titleMedium,
                    ),
                    const SizedBox(height: 2),
                    Text(book.author, style: text.bodySmall),
                    const SizedBox(height: 6),
                    Text(
                      book.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: text.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          size: 16,
                          color: AppColors.star,
                        ),
                        const SizedBox(width: 4),
                        Text('${book.rating}', style: text.bodySmall),
                        const Spacer(),
                        ElevatedButton.icon(
                          onPressed: () => _addToCart(context),
                          icon: const Icon(
                            Icons.shopping_cart_outlined,
                            size: 14,
                          ),
                          label: const Text('Add'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(0, 34),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12),
                            textStyle: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addToCart(BuildContext context) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('"${book.title}" added to cart')));
  }
}
