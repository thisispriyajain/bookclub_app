import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bookclub_app/models/book.dart';

abstract class BookState extends Equatable {
  const BookState();

  @override
  List<Object> get props => [];
}

class BookInitial extends BookState {}

class BookLoading extends BookState {}

class BookLoaded extends BookState {
  final List<Book> books;

  const BookLoaded(this.books);

  @override
  List<Object> get props => [books];
}

class BookCubit extends Cubit<BookState> {
  List<Book> _allBooks = [];

  BookCubit() : super(BookInitial());

  void init() {
    emit(BookLoading());

    _allBooks = [
      Book(
        title: "The Great Gatsby",
        author: "F. Scott Fitzgerald",
        description: "The Great Gatsby is a 1925 novel by F. Scott Fitzgerald that tells the story of Jay Gatsby, a wealthy man who tries to win back his first love, Daisy Buchanan",
        imageURL: "https://m.media-amazon.com/images/I/61dRoDRubtL._SL1500_.jpg?w=400&h=400",
      ),
      Book(
        title: "To Kill a Mockingbird",
        author: "Harper Lee",
        description: "To Kill a Mockingbird is a 1960 novel by Harper Lee that is a coming-of-age story and a drama about racism and prejudice.",
        imageURL: "https://m.media-amazon.com/images/I/81aY1lxk+9L._SL1500_.jpg?w=400&h=400",
      ),
      Book(
        title: "Fahrenheit 451",
        author: "Ray Bradbury",
        description: "Fahrenheit 451 is a dystopian science fiction novel by Ray Bradbury that depicts a future American society where books are banned and burned, and people are numbed by constant noise, advertising, and TVs.",
        imageURL: "https://m.media-amazon.com/images/I/711ZL2p7DmL._SL1500_.jpg?w=400&h=400",
      ),
      Book(
        title: "The Catcher in the Rye",
        author: "J.D. Salinger",
        description: "The Catcher in the Rye by J.D. Salinger is a novel about a 16-year-old boy named Holden Caulfield who is expelled from his prep school and spends two days in New York City.",
        imageURL: "https://m.media-amazon.com/images/I/8125BDk3l9L._SL1500_.jpg?w=400&h=400",
      ),
    ];

  emit(BookLoaded(_allBooks));
}

void filterByTitle() {
  final sortedBooks = List<Book>.from(_allBooks)..sort((a, b) => a.title.compareTo(b.title));
  emit(BookLoaded(sortedBooks));
}

void filterByAuthor() {
  final sortedBooks = List<Book>.from(_allBooks)..sort((a, b) => a.author.compareTo(b.author));
  emit(BookLoaded(sortedBooks));  
}
}