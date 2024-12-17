class Book {
  final String title;
  final String isbn;
  final int year;
  final String publisher;
  final String author;
  final String cover;
  final String synopsis;

  Book({
    required this.title,
    required this.isbn,
    required this.year,
    required this.publisher,
    required this.author,
    required this.cover,
    required this.synopsis,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'isbn': isbn,
        'year': year,
        'publisher': publisher,
        'author': author,
        'cover': cover,
        'synopsis': synopsis,
      };

  static Book fromJson(Map<String, dynamic> json) => Book(
        title: json['title'],
        isbn: json['isbn'],
        year: json['year'],
        publisher: json['publisher'],
        author: json['author'],
        cover: json['cover'],
        synopsis: json['synopsis'],
      );
}
