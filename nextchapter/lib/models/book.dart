class Book {
  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.price,
    required this.rating,
    required this.reviewsCount,
    required this.genres,
    required this.description,
    required this.pages,
    required this.chapters,
    required this.published,
    this.language = 'English',
  });

  final int id;
  final String title;
  final String author;
  final String coverUrl;
  final double price;
  final double rating;
  final int reviewsCount;
  final List<String> genres;
  final String description;
  final int pages;
  final int chapters;
  final String published;
  final String language;

  String get priceLabel => '\$${price.toStringAsFixed(2)}';
  String get primaryGenre => genres.first;
}

/// «Секретная книга»: пользователь видит только жанр, возраст и цену.
class SecretBook {
  const SecretBook({
    required this.genre,
    required this.ageRating,
    required this.price,
    required this.teaser,
  });

  final String genre;
  final String ageRating;
  final double price;
  final String teaser;

  String get priceLabel => '\$${price.toStringAsFixed(2)}';
}
