import '../core.dart';

class BookController extends GetxController {
  final _storage = GetStorage();
  final books = <Book>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadBooks();
  }

  void addBook(Book book) {
    books.add(book);
    saveBooks();
  }

  void saveBooks() {
    final booksJson = books.map((book) => book.toJson()).toList();
    _storage.write('books', booksJson);
  }

  void loadBooks() {
    final booksJson = _storage.read<List<dynamic>>('books') ?? [];
    books.value = booksJson.map((json) => Book.fromJson(json)).toList();
  }

  void deleteBook(Book book) {
    books.remove(book);
    saveBooks();
  }

  void updateBook(int index, Book updatedBook) {
    books[index] = updatedBook;
    saveBooks();
  }
}
