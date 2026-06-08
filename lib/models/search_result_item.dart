class SearchResultItem {
  final String id;
  final String title;
  final String subtitle;
  final String content;
  final String sourceType;
  final String spaceId;
  final String spaceName;
  final DateTime createdAt;

  const SearchResultItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.content,
    required this.sourceType,
    required this.spaceId,
    required this.spaceName,
    required this.createdAt,
  });

  bool matches(String query) {
    final q = query.toLowerCase().trim();

    if (q.isEmpty) return true;

    return title.toLowerCase().contains(q) ||
        subtitle.toLowerCase().contains(q) ||
        content.toLowerCase().contains(q) ||
        sourceType.toLowerCase().contains(q) ||
        spaceName.toLowerCase().contains(q);
  }
}