import '../core.dart';

class BookController extends GetxController {
  final _storage = GetStorage();
  final books = <Book>[].obs;
  var filterBook = <Book>[].obs;
  var searchValue = ''.obs;
  var selectYear = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadBooks();
  }

  void addBook(Book book) {
    books.add(book);
    saveBooks();
  }

  void filterBooks() {
    filterBook.assignAll(books.where((book) {
      final matchesTitle =
          book.title.toLowerCase().contains(searchValue.value.toLowerCase());
      final matchesYear =
          selectYear.value.isEmpty || book.year.toString() == selectYear.value;
      return matchesTitle && matchesYear;
    }));
  }

  void updateSearchQuery(String query) {
    searchValue.value = query;
    filterBooks();
  }

  void updateSelectedYear(String year) {
    selectYear.value = year;
    filterBooks();
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
