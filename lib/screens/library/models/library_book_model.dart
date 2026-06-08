class LibraryBookModel {
  final String id;
  final String title;
  final String author;
  final String coverImage;
  final double progress;
  final int currentPage;
  final int totalPages;
  final bool completed;
  final bool favorite;

  const LibraryBookModel({
    required this.id,
    required this.title,
    required this.author,
    required this.coverImage,
    required this.progress,
    required this.currentPage,
    required this.totalPages,
    required this.completed,
    required this.favorite,
  });
}