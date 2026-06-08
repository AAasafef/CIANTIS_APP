import '../models/search_result_item.dart';

class GlobalSearchService {
  GlobalSearchService._();

  static final GlobalSearchService instance =
      GlobalSearchService._();

  final List<SearchResultItem> _items = [];

  List<SearchResultItem> get items {
    return List.unmodifiable(_items);
  }

  void register(
    SearchResultItem item,
  ) {
    _items.removeWhere(
      (existing) => existing.id == item.id,
    );

    _items.add(item);
  }

  void registerMany(
    List<SearchResultItem> items,
  ) {
    for (final item in items) {
      register(item);
    }
  }

  void remove(
    String id,
  ) {
    _items.removeWhere(
      (item) => item.id == id,
    );
  }

  void clear() {
    _items.clear();
  }

  List<SearchResultItem> search(
    String query,
  ) {
    if (query.trim().isEmpty) {
      final sorted = [..._items];

      sorted.sort(
        (a, b) =>
            b.createdAt.compareTo(a.createdAt),
      );

      return sorted;
    }

    final results = _items.where(
      (item) => item.matches(query),
    );

    final sorted = results.toList();

    sorted.sort(
      (a, b) =>
          b.createdAt.compareTo(a.createdAt),
    );

    return sorted;
  }

  List<SearchResultItem> searchSpace(
    String query,
    String spaceId,
  ) {
    return search(query)
        .where(
          (item) =>
              item.spaceId == spaceId,
        )
        .toList();
  }

  List<SearchResultItem> recent({
    int limit = 20,
  }) {
    final sorted = [..._items];

    sorted.sort(
      (a, b) =>
          b.createdAt.compareTo(a.createdAt),
    );

    return sorted.take(limit).toList();
  }
}