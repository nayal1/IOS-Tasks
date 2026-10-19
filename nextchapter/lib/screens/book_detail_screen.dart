import 'package:flutter/material.dart';

import '../data/mock_books.dart';
import '../models/book.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/book_cover.dart';
import '../widgets/book_cover_tile.dart';
import '../widgets/favorite_button.dart';
import '../widgets/tag_chip.dart';

class BookDetailScreen extends StatefulWidget {
  const BookDetailScreen({super.key, required this.book});

  final Book book;

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  bool _isSaved = false; // «Отложить» перед корзиной
  bool _inCart = false;

  Book get book => widget.book;

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _openBook(Book other) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => BookDetailScreen(book: other)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final similar =
        mockBooks.where((b) => b.id != book.id).take(4).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('NextChapter')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildDetailsCard(),
              const SizedBox(height: 28),
              Text('You May Also Like', style: text.titleLarge),
              const SizedBox(height: 12),
              SizedBox(
                height: 280,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: similar.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 12),
                  itemBuilder: (context, index) => BookCoverTile(
                    book: similar[index],
                    onTap: () => _openBook(similar[index]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNav(),
    );
  }

  /// Адаптивная шапка: на узком экране — колонка, на широком — строка.
  Widget _buildHeader() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 600;

        if (isWide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 240, child: _buildCover()),
              const SizedBox(width: 24),
              Expanded(child: _buildInfo()),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: SizedBox(width: 220, child: _buildCover())),
            const SizedBox(height: 20),
            _buildInfo(),
          ],
        );
      },
    );
  }

  /// Обложка + элементы, наложенные поверх неё через Stack.
  Widget _buildCover() {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 2 / 3,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x33000000),
                  blurRadius: 16,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: BookCover(url: book.coverUrl, radius: 16),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: FavoriteButton(
            onChanged: (isFavorite) => _showMessage(
              isFavorite ? 'Added to favorites' : 'Removed from favorites',
            ),
          ),
        ),
        Positioned(
          left: 10,
          bottom: 10,
          child: _RatingBadge(rating: book.rating),
        ),
      ],
    );
  }

  Widget _buildInfo() {
    final text = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(book.title, style: text.headlineMedium),
        const SizedBox(height: 4),
        Text(
          'by ${book.author}',
          style: text.bodyMedium?.copyWith(color: AppColors.muted),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.star_rounded, size: 18, color: AppColors.star),
            const SizedBox(width: 4),
            Text('${book.rating}', style: text.titleMedium),
            const SizedBox(width: 6),
            Text('(${book.reviewsCount} reviews)', style: text.bodySmall),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [for (final genre in book.genres) TagChip(genre)],
        ),
        const SizedBox(height: 16),
        Text(book.description, style: text.bodyMedium),
        const SizedBox(height: 16),
        Text(
          book.priceLabel,
          style: text.headlineMedium?.copyWith(fontSize: 28),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            OutlinedButton(
              onPressed: () {
                setState(() => _isSaved = !_isSaved);
                _showMessage(
                  _isSaved ? 'Saved for later' : 'Removed from saved',
                );
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(48, 48),
                padding: EdgeInsets.zero,
              ),
              child: Icon(
                _isSaved ? Icons.bookmark : Icons.bookmark_border,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() => _inCart = !_inCart);
                  _showMessage(
                    _inCart ? 'Added to cart' : 'Removed from cart',
                  );
                },
                icon: Icon(
                  _inCart ? Icons.check : Icons.shopping_cart_outlined,
                  size: 18,
                ),
                label: Text(_inCart ? 'In cart' : 'Add to Cart'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(0, 48),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: () => _showMessage('Preview is coming soon'),
          style: OutlinedButton.styleFrom(minimumSize: const Size(0, 44)),
          child: const Text('Read Preview'),
        ),
      ],
    );
  }

  Widget _buildDetailsCard() {
    final text = Theme.of(context).textTheme;

    return Card(
      margin: EdgeInsets.zero,
      color: AppColors.surface,
      elevation: 2,
      shadowColor: AppColors.shadow,
      shape: AppTheme.cardShape,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Book Details', style: text.titleMedium),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _DetailItem('Pages', '${book.pages}')),
                Expanded(child: _DetailItem('Chapters', '${book.chapters}')),
                Expanded(child: _DetailItem('Language', book.language)),
                Expanded(child: _DetailItem('Published', book.published)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RatingBadge extends StatelessWidget {
  const _RatingBadge({required this.rating});

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xE6FFFFFF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star_rounded, size: 16, color: AppColors.star),
          const SizedBox(width: 4),
          Text(
            '$rating',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontSize: 13,
                ),
          ),
        ],
      ),
    );
  }
}

class _DetailItem extends StatelessWidget {
  const _DetailItem(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: text.bodySmall),
        const SizedBox(height: 2),
        Text(
          value,
          style: text.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
