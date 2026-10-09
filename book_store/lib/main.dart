
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFAF6F0),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF79583F),
        ),
      ),
      home: const BookDetailScreen(),
    );
  }
}

class BookDetailScreen extends StatefulWidget {
  const BookDetailScreen({super.key});

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  // Product state
  bool isFavorite = false;
  bool isInCart = false;

  // User rating
  int userRating = 0;

  // Book information
  final String bookTitle = 'The Great Gatsby';
  final String author = 'F. Scott Fitzgerald';
  final double price = 6500.0;

  final Color brown = const Color(0xFF79583F);
  final Color beige = const Color(0xFFEDE1D2);
  final Color cream = const Color(0xFFFAF6F0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream,

      appBar: AppBar(
        title: const Text('Book Details'),
        backgroundColor: cream,
        foregroundColor: brown,
        elevation: 0,
      ),

      // Scrollable product information
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Book cover and bookmark button
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=900',
                      width: double.infinity,
                      height: 280,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: double.infinity,
                          height: 280,
                          color: beige,
                          child: Icon(
                            Icons.menu_book,
                            size: 80,
                            color: brown,
                          ),
                        );
                      },
                    ),
                  ),

                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      decoration: BoxDecoration(
                        color: cream,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        icon: Icon(
                          isFavorite
                              ? Icons.bookmark
                              : Icons.bookmark_border,
                          color: brown,
                          size: 28,
                        ),
                        tooltip: isFavorite
                            ? 'Remove from Favorites'
                            : 'Add to Favorites',
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Book title
              Text(
                bookTitle,
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: brown,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                author,
                style: TextStyle(
                  fontSize: 17,
                  color: brown.withValues(alpha: 0.75),
                ),
              ),

              const SizedBox(height: 18),

              // Interactive star rating
              Row(
                children: [
                  for (int i = 1; i <= 5; i++)
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (userRating == i) {
                            userRating = 0; // Reset rating if same star is tapped
                          } else {
                            userRating = i;
                          }
                        });
                      },
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 36,
                        minHeight: 40,
                      ),
                      icon: Icon(
                        i <= userRating
                            ? Icons.star
                            : Icons.star_border,
                        color: brown,
                        size: 30,
                      ),
                    ),
                  const SizedBox(width: 8),
                  Text(
                    userRating == 0
                        ? 'Rate this book'
                        : '$userRating / 5',
                    style: TextStyle(
                      color: brown,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Price
              Text(
                '${price.toStringAsFixed(0)} ₸',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: brown,
                ),
              ),

              const SizedBox(height: 22),

              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: brown,
                ),
              ),

              const SizedBox(height: 12),

              // Category badges automatically wrap
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  categoryBadge('Classic'),
                  categoryBadge('Fiction'),
                  categoryBadge('Drama'),
                  categoryBadge('Romance'),
                ],
              ),

              const SizedBox(height: 26),

              Text(
                'About this book',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: brown,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                'The Great Gatsby is a classic novel about '
                'love, ambition, wealth, and the American Dream. '
                'Set in the 1920s, it follows Jay Gatsby and '
                'his mysterious life as he tries to reunite '
                'with his past love.',
                style: TextStyle(
                  fontSize: 15,
                  height: 1.6,
                  color: brown.withValues(alpha: 0.85),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

      // Sticky bottom action bar
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cream,
            boxShadow: [
              BoxShadow(
                color: brown.withValues(alpha: 0.12),
                blurRadius: 12,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isInCart = !isInCart;
                            });
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: brown,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor:
                          brown.withValues(alpha: 0.55),
                      disabledForegroundColor:
                          Colors.white.withValues(alpha: 0.9),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isInCart
                              ? Icons.check_circle
                              : Icons.shopping_cart_outlined,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          isInCart ? 'In Cart' : 'Add to Cart',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable category badge
  Widget categoryBadge(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: beige,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: brown,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}