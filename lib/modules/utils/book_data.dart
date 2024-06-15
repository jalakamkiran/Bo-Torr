import 'package:libgen/models/home_page_model.dart';

class BookData {
  static BookData _instance = BookData._internal();

  BookData._internal();

  late Books _selectedBook;


  Books get selectedBook => _selectedBook;

  set selectedBook(Books value) {
    _selectedBook = value;
  }

  factory BookData() {
    return _instance;
  }
}