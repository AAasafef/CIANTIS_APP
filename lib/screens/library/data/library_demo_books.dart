import '../models/library_book_model.dart';

const List<LibraryBookModel> demoBooks = [
  LibraryBookModel(
    id: '1',
    title: 'Business Foundations',
    author: 'Personal Library',
    coverImage: '',
    progress: 0.62,
    currentPage: 186,
    totalPages: 300,
    completed: false,
    favorite: true,
  ),

  LibraryBookModel(
    id: '2',
    title: 'Nursing Pharmacology',
    author: 'Study Collection',
    coverImage: '',
    progress: 0.34,
    currentPage: 97,
    totalPages: 280,
    completed: false,
    favorite: false,
  ),

  LibraryBookModel(
    id: '3',
    title: 'Spiritual Growth',
    author: 'Faith Collection',
    coverImage: '',
    progress: 1.0,
    currentPage: 240,
    totalPages: 240,
    completed: true,
    favorite: true,
  ),
];