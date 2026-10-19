
import 'package:flutter/material.dart';

void main() {
  runApp(const BookNavigationApp());
}

// Book data model
class Book {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  final String category;

  const Book({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.category,
  });
}

// Sample books
const List<Book> books = [
  Book(
    id: 1,
    title: 'The Great Gatsby',
    description:
        'A classic novel by F. Scott Fitzgerald about Jay Gatsby, '
        'his mysterious past, and his dream of reuniting with Daisy Buchanan.',
    imageUrl:
        'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=500',
    price: 4500,
    category: 'Classic Fiction',
  ),
  Book(
    id: 2,
    title: 'Pride and Prejudice',
    description:
        'Jane Austen tells the story of Elizabeth Bennet and '
        'Mr. Darcy, exploring love, family, and first impressions.',
    imageUrl:
        'https://images.unsplash.com/photo-1512820790803-83ca734da794?w=500',
    price: 5200,
    category: 'Romance',
  ),
  Book(
    id: 3,
    title: 'The Silent Patient',
    description:
        'A psychological thriller about a famous painter who stops '
        'speaking after a shocking event, and the therapist who tries '
        'to understand her silence.',
    imageUrl:
        'https://images.unsplash.com/photo-1519682337058-a94d519337bc?w=500',
    price: 6100,
    category: 'Thriller',
  ),
  Book(
    id: 4,
    title: 'Little Women',
    description:
        'Louisa May Alcott follows four sisters as they grow up, '
        'face challenges, and discover what matters most in life.',
    imageUrl:
        'https://images.unsplash.com/photo-1513001900722-370f803f498d?w=500',
    price: 4800,
    category: 'Classic Fiction',
  ),
];

const Color beige = Color(0xFFF6F0E8);
const Color brown = Color(0xFF795548);
const Color darkBrown = Color(0xFF4E342E);

// Main application
class BookNavigationApp extends StatelessWidget {
  const BookNavigationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Book Store',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: beige,
        colorScheme: ColorScheme.fromSeed(seedColor: brown),
        appBarTheme: const AppBarTheme(
          backgroundColor: beige,
          foregroundColor: darkBrown,
          centerTitle: true,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

// Root screen with bottom navigation
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Shared favorites list
  final List<Book> _favorites = [];

  bool _isFavorite(Book book) {
    return _favorites.any((item) => item.id == book.id);
  }

  void _toggleFavorite(Book book) {
    setState(() {
      if (_isFavorite(book)) {
        _favorites.removeWhere((item) => item.id == book.id);
      } else {
        _favorites.add(book);
      }
    });
  }

  // Opens the detail screen and passes the complete Book object.
  void _openDetails(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(
          book: book,
          isFavorite: _isFavorite(book),
          onToggleFavorite: () => _toggleFavorite(book),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      FeedScreen(
        books: books,
        onBookTap: _openDetails,
        isFavorite: _isFavorite,
        onToggleFavorite: _toggleFavorite,
      ),
      FavoritesScreen(
        favorites: _favorites,
        onBookTap: _openDetails,
        onRemoveFavorite: _toggleFavorite,
      ),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: Colors.white,
        selectedItemColor: brown,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Tab 1: Book catalog
class FeedScreen extends StatelessWidget {
  final List<Book> books;
  final ValueChanged<Book> onBookTap;
  final bool Function(Book) isFavorite;
  final ValueChanged<Book> onToggleFavorite;

  const FeedScreen({
    super.key,
    required this.books,
    required this.onBookTap,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Book Store',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Discover your next favorite book.',
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          const SizedBox(height: 16),
          ...books.map(
            (book) => BookCard(
              book: book,
              isFavorite: isFavorite(book),
              onTap: () => onBookTap(book),
              onFavoriteTap: () => onToggleFavorite(book),
            ),
          ),
        ],
      ),
    );
  }
}

// Reusable book card
class BookCard extends StatelessWidget {
  final Book book;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;

  const BookCard({
    super.key,
    required this.book,
    required this.isFavorite,
    required this.onTap,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 14),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  book.imageUrl,
                  width: 90,
                  height: 125,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 90,
                      height: 125,
                      color: beige,
                      child: const Icon(
                        Icons.menu_book,
                        size: 40,
                        color: brown,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: darkBrown,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      book.category,
                      style: const TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${book.price.toStringAsFixed(0)} ₸',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: brown,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Tap to view details',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onFavoriteTap,
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : brown,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Tab 2: Favorites
class FavoritesScreen extends StatelessWidget {
  final List<Book> favorites;
  final ValueChanged<Book> onBookTap;
  final ValueChanged<Book> onRemoveFavorite;

  const FavoritesScreen({
    super.key,
    required this.favorites,
    required this.onBookTap,
    required this.onRemoveFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Favorites',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: favorites.isEmpty
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 60,
                    color: brown,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'No favorite books yet.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 6),
                  Text('Add books from the Feed tab.'),
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: favorites
                  .map(
                    (book) => BookCard(
                      book: book,
                      isFavorite: true,
                      onTap: () => onBookTap(book),
                      onFavoriteTap: () => onRemoveFavorite(book),
                    ),
                  )
                  .toList(),
            ),
    );
  }
}

// Tab 3: Profile
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 48,
            backgroundColor: Color(0xFFE5D2BF),
            child: Icon(
              Icons.person,
              size: 55,
              color: darkBrown,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Book Lover',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: darkBrown,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'reader@example.com',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 30),
          const Card(
            color: Colors.white,
            child: ListTile(
              leading: Icon(Icons.notifications_outlined, color: brown),
              title: Text('Notifications'),
              subtitle: Text('Manage notifications'),
            ),
          ),
          const Card(
            color: Colors.white,
            child: ListTile(
              leading: Icon(Icons.language, color: brown),
              title: Text('Language'),
              subtitle: Text('English'),
            ),
          ),
          const Card(
            color: Colors.white,
            child: ListTile(
              leading: Icon(Icons.settings_outlined, color: brown),
              title: Text('Settings'),
              subtitle: Text('App preferences'),
            ),
          ),
        ],
      ),
    );
  }
}

// Detail screen: receives a complete Book object
class DetailScreen extends StatefulWidget {
  final Book book;
  final bool isFavorite;
  final VoidCallback onToggleFavorite;

  const DetailScreen({
    super.key,
    required this.book,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });

    widget.onToggleFavorite();
  }

  @override
  Widget build(BuildContext context) {
    final book = widget.book;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Details'),
        actions: [
          IconButton(
            onPressed: _toggleFavorite,
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : brown,
            ),
            tooltip: 'Toggle favorite',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                book.imageUrl,
                height: 280,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 280,
                    color: const Color(0xFFE5D2BF),
                    child: const Icon(
                      Icons.menu_book,
                      size: 100,
                      color: brown,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 22),
            Text(
              book.title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: darkBrown,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              book.category,
              style: const TextStyle(
                fontSize: 16,
                color: brown,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '${book.price.toStringAsFixed(0)} ₸',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: darkBrown,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'About this book',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              book.description,
              style: const TextStyle(
                fontSize: 16,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 30),

            // Returns to the previous screen.
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text('Back to Books'),
              style: ElevatedButton.styleFrom(
                backgroundColor: brown,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.all(16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
