import 'package:flutter/material.dart';

import '../data/mock_books.dart';
import '../models/book.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bottom_nav.dart';
import '../widgets/book_card.dart';
import '../widgets/book_cover_tile.dart';
import '../widgets/secret_book_banner.dart';
import 'book_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _genres = [
    'All',
    'Fiction',
    'Self-Help',
    'Sci-Fi',
    'Memoir',
    'Business',
    'Fantasy',
  ];

  String _selectedGenre = 'All';

  void _openBook(Book book) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => BookDetailScreen(book: book)),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  List<Book> _byPrimaryGenre(List<String> genres) => mockBooks
      .where((book) => genres.contains(book.primaryGenre))
      .take(2)
      .toList();

  @override
  Widget build(BuildContext context) {
    final recommended = mockBooks.take(5).toList();

    final topSelling = mockBooks
        .where((book) =>
            book.rating >= 4.7 &&
            (_selectedGenre == 'All' || book.genres.contains(_selectedGenre)))
        .take(4)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('NextChapter'),
        actions: [
          IconButton(
            onPressed: () => _showMessage('Cart is coming soon'),
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 4, right: 16),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.primary,
              child: Text(
                'JD',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: [
          _buildSearchField(),
          const SizedBox(height: 16),
          _buildGenreChips(),
          const SizedBox(height: 24),

          // Рекомендации
          const _SectionHeader(
            title: 'Recommended for you',
            subtitle: 'Based on your reading taste',
          ),
          SizedBox(
            height: 280,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: recommended.length,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (context, index) => BookCoverTile(
                book: recommended[index],
                onTap: () => _openBook(recommended[index]),
              ),
            ),
          ),
          const SizedBox(height: 28),

          // Секретная книга
          const _SectionHeader(
            title: 'Secret Book',
            subtitle: 'Choose the mood, not the title',
          ),
          SecretBookBanner(
            secretBook: mockSecretBook,
            onTap: () => _showMessage('Surprise book added to cart'),
          ),
          const SizedBox(height: 28),

          // Топ продаж (фильтруется чипами жанров)
          const _SectionHeader(title: 'Top Selling'),
          if (topSelling.isEmpty)
            Text(
              'No top sellers in this genre yet',
              style: Theme.of(context).textTheme.bodySmall,
            )
          else
            _buildBookList(topSelling),
          const SizedBox(height: 16),

          const _SectionHeader(title: 'Popular in Fiction'),
          _buildBookList(_byPrimaryGenre(['Fiction'])),
          const SizedBox(height: 16),

          const _SectionHeader(title: 'Business & Self-development'),
          _buildBookList(_byPrimaryGenre(['Business', 'Self-Help'])),
          const SizedBox(height: 16),

          const _SectionHeader(title: 'Fantasy & Sci-Fi'),
          _buildBookList(_byPrimaryGenre(['Fantasy', 'Sci-Fi'])),
        ],
      ),
      bottomNavigationBar: const AppBottomNav(),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search books, authors, genres...',
        hintStyle: const TextStyle(color: AppColors.muted, fontSize: 14),
        prefixIcon: const Icon(Icons.search, color: AppColors.muted),
        filled: true,
        fillColor: AppColors.chip,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildGenreChips() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _genres.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final genre = _genres[index];
          final selected = genre == _selectedGenre;
          return ChoiceChip(
            label: Text(genre),
            selected: selected,
            showCheckmark: false,
            selectedColor: AppColors.primary,
            backgroundColor: AppColors.chip,
            side: BorderSide.none,
            shape: const StadiumBorder(),
            labelStyle: TextStyle(
              fontSize: 13,
              color: selected ? Colors.white : AppColors.ink,
            ),
            onSelected: (_) => setState(() => _selectedGenre = genre),
          );
        },
      ),
    );
  }

  Widget _buildBookList(List<Book> books) {
    return Column(
      children: [
        for (final book in books)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: BookCard(book: book, onTap: () => _openBook(book)),
          ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: text.titleLarge),
          if (subtitle != null) ...[
            const SizedBox(height: 2),
            Text(subtitle!, style: text.bodySmall),
          ],
        ],
      ),
    );
  }
}
