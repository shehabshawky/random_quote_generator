class Quote {
  final String id;
  final String text;
  final String author;
  final String category;

  const Quote({
    required this.id,
    required this.text,
    required this.author,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'text': text,
      'author': author,
      'category': category,
    };
  }

  factory Quote.fromMap(Map<String, dynamic> map) {
    return Quote(
      id: map['id'] as String,
      text: map['text'] as String,
      author: map['author'] as String,
      category: map['category'] as String,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Quote &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          text == other.text &&
          author == other.author;

  @override
  int get hashCode => id.hashCode ^ text.hashCode ^ author.hashCode;
}
