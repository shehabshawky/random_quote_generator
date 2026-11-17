import 'dart:math';
import '../models/quote_model.dart';

class QuoteRepository {
  static final Random _random = Random();

  static const List<String> categories = [
    'All',
    'Wisdom',
    'Inspiration',
    'Success',
    'Life',
    'Philosophy',
    'Mindfulness',
  ];

  static const List<Quote> quotes = [
    Quote(
      id: '1',
      text: 'The only way to do great work is to love what you do.',
      author: 'Steve Jobs',
      category: 'Success',
    ),
    Quote(
      id: '2',
      text: 'In the middle of difficulty lies opportunity.',
      author: 'Albert Einstein',
      category: 'Inspiration',
    ),
    Quote(
      id: '3',
      text: 'We are what we repeatedly do. Excellence, then, is not an act, but a habit.',
      author: 'Will Durant',
      category: 'Wisdom',
    ),
    Quote(
      id: '4',
      text: 'Life is what happens when you’re busy making other plans.',
      author: 'John Lennon',
      category: 'Life',
    ),
    Quote(
      id: '5',
      text: 'Happiness is not something ready made. It comes from your own actions.',
      author: 'Dalai Lama',
      category: 'Mindfulness',
    ),
    Quote(
      id: '6',
      text: 'He who has a why to live can bear almost any how.',
      author: 'Friedrich Nietzsche',
      category: 'Philosophy',
    ),
    Quote(
      id: '7',
      text: 'The journey of a thousand miles begins with a single step.',
      author: 'Lao Tzu',
      category: 'Wisdom',
    ),
    Quote(
      id: '8',
      text: 'It always seems impossible until it’s done.',
      author: 'Nelson Mandela',
      category: 'Inspiration',
    ),
    Quote(
      id: '9',
      text: 'Do not go where the path may lead, go instead where there is no path and leave a trail.',
      author: 'Ralph Waldo Emerson',
      category: 'Success',
    ),
    Quote(
      id: '10',
      text: 'The unexamined life is not worth living.',
      author: 'Socrates',
      category: 'Philosophy',
    ),
    Quote(
      id: '11',
      text: 'Simplicity is the ultimate sophistication.',
      author: 'Leonardo da Vinci',
      category: 'Wisdom',
    ),
    Quote(
      id: '12',
      text: 'Peace comes from within. Do not seek it without.',
      author: 'Buddha',
      category: 'Mindfulness',
    ),
    Quote(
      id: '13',
      text: 'Believe you can and you’re halfway there.',
      author: 'Theodore Roosevelt',
      category: 'Inspiration',
    ),
    Quote(
      id: '14',
      text: 'Turn your wounds into wisdom.',
      author: 'Oprah Winfrey',
      category: 'Life',
    ),
    Quote(
      id: '15',
      text: 'You miss 100% of the shots you don’t take.',
      author: 'Wayne Gretzky',
      category: 'Success',
    ),
    Quote(
      id: '16',
      text: 'Waste no more time arguing what a good man should be. Be one.',
      author: 'Marcus Aurelius',
      category: 'Philosophy',
    ),
    Quote(
      id: '17',
      text: 'To live is the rarest thing in the world. Most people exist, that is all.',
      author: 'Oscar Wilde',
      category: 'Life',
    ),
    Quote(
      id: '18',
      text: 'Act as if what you do makes a difference. It does.',
      author: 'William James',
      category: 'Inspiration',
    ),
    Quote(
      id: '19',
      text: 'The best way to predict your future is to create it.',
      author: 'Peter Drucker',
      category: 'Success',
    ),
    Quote(
      id: '20',
      text: 'Silence is sometimes the best answer.',
      author: 'Dalai Lama',
      category: 'Mindfulness',
    ),
    Quote(
      id: '21',
      text: 'Knowing yourself is the beginning of all wisdom.',
      author: 'Aristotle',
      category: 'Philosophy',
    ),
    Quote(
      id: '22',
      text: 'Everything you can imagine is real.',
      author: 'Pablo Picasso',
      category: 'Inspiration',
    ),
    Quote(
      id: '23',
      text: 'What lies behind us and what lies before us are tiny matters compared to what lies within us.',
      author: 'Henry Stanley Haskins',
      category: 'Wisdom',
    ),
    Quote(
      id: '24',
      text: 'Change your thoughts and you change your world.',
      author: 'Norman Vincent Peale',
      category: 'Mindfulness',
    ),
    Quote(
      id: '25',
      text: 'The purpose of our lives is to be happy.',
      author: 'Dalai Lama',
      category: 'Life',
    ),
    Quote(
      id: '26',
      text: 'I have not failed. I’ve just found 10,000 ways that won’t work.',
      author: 'Thomas A. Edison',
      category: 'Success',
    ),
    Quote(
      id: '27',
      text: 'We suffer more often in imagination than in reality.',
      author: 'Seneca',
      category: 'Philosophy',
    ),
    Quote(
      id: '28',
      text: 'Be kind whenever possible. It is always possible.',
      author: 'Dalai Lama',
      category: 'Life',
    ),
  ];

  /// Returns a random quote, ensuring it differs from [currentQuote] if more than 1 option exists.
  static Quote getRandomQuote({String category = 'All', Quote? currentQuote}) {
    List<Quote> pool = quotes;
    if (category != 'All') {
      pool = quotes.where((q) => q.category.toLowerCase() == category.toLowerCase()).toList();
      if (pool.isEmpty) pool = quotes;
    }

    if (pool.length <= 1) {
      return pool.first;
    }

    // Filter out the current quote so the user always gets a different quote on click
    final eligible = pool.where((q) => q.id != currentQuote?.id).toList();
    final sourceList = eligible.isNotEmpty ? eligible : pool;
    return sourceList[_random.nextInt(sourceList.length)];
  }
}
