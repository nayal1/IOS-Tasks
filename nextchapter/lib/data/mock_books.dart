import '../models/book.dart';

const mockSecretBook = SecretBook(
  genre: 'Mystery',
  ageRating: '16+',
  price: 9.99,
  teaser: 'A wrapped surprise picked by our booksellers. '
      'The title and author are revealed only after you open it.',
);

const List<Book> mockBooks = [
  Book(
    id: 1,
    title: 'The Midnight Library',
    author: 'Matt Haig',
    coverUrl: 'https://picsum.photos/seed/midnight-library/400/600',
    price: 16.99,
    rating: 4.6,
    reviewsCount: 2847,
    genres: ['Fiction', 'Fantasy', 'Contemporary'],
    description:
        'Between life and death there is a library, and within that library, '
        'the shelves go on forever. Every book provides a chance to try '
        'another life you could have lived. Would you do anything different, '
        'if you had the chance to undo your regrets?',
    pages: 304,
    chapters: 68,
    published: 'Aug 13, 2020',
  ),
  Book(
    id: 2,
    title: 'Atomic Habits',
    author: 'James Clear',
    coverUrl: 'https://picsum.photos/seed/atomic-habits/400/600',
    price: 18.99,
    rating: 4.8,
    reviewsCount: 5120,
    genres: ['Self-Help', 'Business'],
    description:
        'A practical guide to building good habits and breaking bad ones. '
        'Tiny changes, remarkable results.',
    pages: 320,
    chapters: 20,
    published: 'Oct 16, 2018',
  ),
  Book(
    id: 3,
    title: 'Project Hail Mary',
    author: 'Andy Weir',
    coverUrl: 'https://picsum.photos/seed/hail-mary/400/600',
    price: 19.99,
    rating: 4.8,
    reviewsCount: 3980,
    genres: ['Sci-Fi', 'Adventure'],
    description:
        'A lone astronaut wakes up on a spaceship with no memory and must '
        'save humanity from extinction.',
    pages: 496,
    chapters: 48,
    published: 'May 4, 2021',
  ),
  Book(
    id: 4,
    title: 'The Seven Husbands of Evelyn Hugo',
    author: 'Taylor Jenkins Reid',
    coverUrl: 'https://picsum.photos/seed/evelyn-hugo/400/600',
    price: 17.99,
    rating: 4.7,
    reviewsCount: 4310,
    genres: ['Fiction', 'Romance'],
    description:
        'A reclusive Hollywood icon finally decides to tell the truth about '
        'her glamorous and scandalous life.',
    pages: 400,
    chapters: 30,
    published: 'Jun 13, 2017',
  ),
  Book(
    id: 5,
    title: 'Educated',
    author: 'Tara Westover',
    coverUrl: 'https://picsum.photos/seed/educated-book/400/600',
    price: 16.50,
    rating: 4.8,
    reviewsCount: 3655,
    genres: ['Memoir'],
    description:
        'A memoir about a girl who grows up in the mountains of Idaho and '
        'finds her way to the classroom.',
    pages: 352,
    chapters: 35,
    published: 'Feb 20, 2018',
  ),
  Book(
    id: 6,
    title: 'Tomorrow, and Tomorrow, and Tomorrow',
    author: 'Gabrielle Zevin',
    coverUrl: 'https://picsum.photos/seed/tomorrow-book/400/600',
    price: 15.99,
    rating: 4.8,
    reviewsCount: 2210,
    genres: ['Fiction'],
    description:
        'A sweeping novel about friendship, creativity, and the choices '
        'that shape our lives.',
    pages: 416,
    chapters: 40,
    published: 'Jul 5, 2022',
  ),
  Book(
    id: 7,
    title: 'The Psychology of Money',
    author: 'Morgan Housel',
    coverUrl: 'https://picsum.photos/seed/psychology-money/400/600',
    price: 17.50,
    rating: 4.9,
    reviewsCount: 4890,
    genres: ['Business', 'Self-Help'],
    description:
        'Timeless lessons on wealth, greed, and happiness in a modern '
        'master class about money.',
    pages: 256,
    chapters: 20,
    published: 'Sep 8, 2020',
  ),
  Book(
    id: 8,
    title: 'Lessons in Chemistry',
    author: 'Bonnie Garmus',
    coverUrl: 'https://picsum.photos/seed/lessons-chemistry/400/600',
    price: 16.00,
    rating: 4.7,
    reviewsCount: 3120,
    genres: ['Fiction', 'Historical'],
    description:
        'A brilliant scientist in 1960s California breaks barriers in her '
        'own unique way.',
    pages: 400,
    chapters: 61,
    published: 'Apr 5, 2022',
  ),
  Book(
    id: 9,
    title: 'Deep Work',
    author: 'Cal Newport',
    coverUrl: 'https://picsum.photos/seed/deep-work/400/600',
    price: 15.50,
    rating: 4.7,
    reviewsCount: 2780,
    genres: ['Self-Help', 'Business'],
    description:
        'Rules for focused success in a distracted world. Learn to master '
        'the skills that matter most.',
    pages: 304,
    chapters: 12,
    published: 'Jan 5, 2016',
  ),
  Book(
    id: 10,
    title: 'The Name of the Wind',
    author: 'Patrick Rothfuss',
    coverUrl: 'https://picsum.photos/seed/name-of-wind/400/600',
    price: 18.00,
    rating: 4.9,
    reviewsCount: 6040,
    genres: ['Fantasy', 'Adventure'],
    description:
        'The riveting first-person narrative of a young man who grows to be '
        'a notorious magician.',
    pages: 672,
    chapters: 92,
    published: 'Mar 27, 2007',
  ),
  Book(
    id: 11,
    title: 'The Way of Kings',
    author: 'Brandon Sanderson',
    coverUrl: 'https://picsum.photos/seed/way-of-kings/400/600',
    price: 21.00,
    rating: 4.8,
    reviewsCount: 5230,
    genres: ['Fantasy', 'Epic'],
    description:
        'An epic tale of war, betrayal, and the awakening of ancient '
        'powers on a storm-swept world.',
    pages: 1007,
    chapters: 75,
    published: 'Aug 31, 2010',
  ),
];
