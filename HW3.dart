abstract class MediaItem {
  String id;
  String title;
  double price;

  MediaItem({
    required this.id,
    required this.title,
    required this.price,
  });

  String getDetails();
}

mixin Downloadable {
  void download(String title) {
    print("Downloading: $title");
  }
}

class Audiobook extends MediaItem with Downloadable {
  double durationHours;
  String narrator;

  Audiobook({
    required super.id,
    required super.title,
    required super.price,
    required this.durationHours,
    required this.narrator,
  });

  @override
  String getDetails() {
    return "Audiobook: $title | Narrator: $narrator | Duration: $durationHours hours | Price: $price";
  }
}

class EBook extends MediaItem with Downloadable {
  double fileSizeMB;
  String author;

  EBook({
    required super.id,
    required super.title,
    required super.price,
    required this.fileSizeMB,
    required this.author,
  });

  @override
  String getDetails() {
    return "EBook: $title | Author: $author | File size: $fileSizeMB MB | Price: $price";
  }
}

class ShoppingCart {
  List<MediaItem> _items = [];

  void addItem(MediaItem item) {
    _items.add(item);
  }

  double calculateTotalWithTax({double taxRate = 0.12}) {
    double total = _items.fold(
      0.0,
      (sum, item) => sum + item.price,
    );

    return total + (total * taxRate);
  }

  List<MediaItem> filterByMaxPrice(double maxPrice) {
    return _items
        .where((item) => item.price <= maxPrice)
        .toList();
  }

  void printReceipt() {
    print("----- RECEIPT -----");

    for (MediaItem item in _items) {
      print(item.getDetails());

      if (item is Downloadable) {
        (item as Downloadable).download(item.title);
      }
    }

    print("Total with tax: ${calculateTotalWithTax()}");
  }
}

void main() {
  ShoppingCart cart = ShoppingCart();

  Audiobook audiobook = Audiobook(
    id: "A001",
    title: "Harry Potter",
    price: 5000.0,
    durationHours: 8.5,
    narrator: "Stephen Fry",
  );

  EBook ebook = EBook(
    id: "E001",
    title: "1984",
    price: 3500.0,
    fileSizeMB: 2.5,
    author: "George Orwell",
  );

  cart.addItem(audiobook);
  cart.addItem(ebook);

  cart.printReceipt();

  print("Books under 4000 ₸:");

  for (MediaItem item in cart.filterByMaxPrice(4000.0)) {
    print(item.getDetails());
  }
}