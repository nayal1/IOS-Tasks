# NextChapter 📚

A mobile online bookstore built with Flutter. NextChapter combines a classic
marketplace with personalized recommendations, "secret" books and reading clubs.

This is the capstone project for the iOS Development course. It will be
extended throughout the semester with REST APIs, a database and BLoC architecture.

## The Idea

Regular online bookstores rarely help readers choose what to read next, and they
offer no way for readers to talk to each other. NextChapter addresses both
problems: it recommends books based on personal taste and brings readers
together in interest-based clubs.

## Key Features

- **Favorites + AI recommendations**: readers can add a book not only to
  "Saved" (before checkout) but also to "Favorites". The favorites list will be
  used to generate personalized recommendations. *(planned)*
- **Secret books**: buy a mystery book without knowing what it is. Only the
  genre, the age rating and the price are shown. The title is revealed after
  purchase.
- **Book clubs**: join interest-based clubs inside the app, publish posts
  (reading impressions, recommendation requests), and comment on and like posts.
  *(planned)*
- **Standard marketplace features**: catalog, search, genre filters, book
  details, saved items, cart.

## Milestone 1 (current state)

Static MVP interface built on mock data.

**Screens**
- **Home**: search field, genre filter chips, "Recommended for you", the
  "Secret Book" block, and curated sections (Top Selling, Fiction,
  Business & Self-development, Fantasy & Sci-Fi).
- **Book details**: cover with a `Stack` overlay (rating badge and favorite
  button), tags, description, price, book details card and "You May Also Like".
- **Bottom navigation** on every screen: Home, Saved, Favorites, Clubs, Cart
  (placeholders for now, except Home).

**Interactivity (`StatefulWidget` + `setState`)**
- Favorite (heart) button on the book cover
- "Save for later" bookmark button
- "Add to Cart" toggle
- Genre filter chips on the home screen, which filter the "Top Selling" list

**Layout**
- Responsive book details header: a column on phones and a row on wide screens
  (600 px and above)
- Warm beige and light-brown theme, serif headings (Lora) and Inter for body text

## Project Structure

```
lib/
├── main.dart
├── theme/        # colors and app theme
├── models/       # Book, SecretBook
├── data/         # mock data
├── screens/      # home_screen, book_detail_screen
└── widgets/      # reusable widgets (book cards, favorite button,
                  # secret book banner, bottom navigation, tags, ...)
```

## Tech Stack

- Flutter / Dart
- [`google_fonts`](https://pub.dev/packages/google_fonts)

## Getting Started

1. Make sure [Flutter](https://docs.flutter.dev/get-started/install) is installed.
2. Clone the repository and open the project folder.
3. Install dependencies:
   ```
   flutter pub get
   ```
4. Run the app on a simulator or a connected device:
   ```
   flutter run
   ```

An internet connection is required: book covers are placeholder images loaded
from the network, and fonts are fetched by `google_fonts`.

## Roadmap

- [ ] Working screens for Saved, Favorites, Cart and Clubs
- [ ] REST API integration instead of mock data
- [ ] Local database
- [ ] BLoC state management
- [ ] AI-powered recommendations based on the favorites list
- [ ] Secret book purchase flow
- [ ] Clubs: posts, comments and likes
- [ ] Checkout and user profile