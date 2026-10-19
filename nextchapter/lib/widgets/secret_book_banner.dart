import 'package:flutter/material.dart';

import '../models/book.dart';
import '../theme/app_theme.dart';
import 'tag_chip.dart';

/// Блок «Секретная книга» в том же стиле, что и карточки книг:
/// вместо обложки — «завёрнутая» книга со знаком вопроса.
/// Видны только жанр, возрастное ограничение и цена.
class SecretBookBanner extends StatelessWidget {
  const SecretBookBanner({
    super.key,
    required this.secretBook,
    required this.onTap,
  });

  final SecretBook secretBook;
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
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 84,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.accent, width: 2),
              ),
              alignment: Alignment.center,
              child: Text(
                '?',
                style: text.headlineMedium?.copyWith(
                  fontSize: 44,
                  color: AppColors.background,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Surprise Book', style: text.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    secretBook.teaser,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: text.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      TagChip(secretBook.genre),
                      TagChip(secretBook.ageRating),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        secretBook.priceLabel,
                        style: text.titleMedium?.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton.icon(
                        onPressed: onTap,
                        icon: const Icon(Icons.card_giftcard, size: 14),
                        label: const Text('Get it'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(0, 34),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
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
    );
  }
}
