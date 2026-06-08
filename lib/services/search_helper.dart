import '../models/search_result_item.dart';
import 'global_search_service.dart';

class SearchHelper {
  SearchHelper._();

  static void register({
    required String id,
    required String title,
    required String subtitle,
    required String content,
    required String sourceType,
    required String spaceId,
    required String spaceName,
  }) {
    GlobalSearchService.instance.register(
      SearchResultItem(
        id: id,
        title: title,
        subtitle: subtitle,
        content: content,
        sourceType: sourceType,
        spaceId: spaceId,
        spaceName: spaceName,
        createdAt: DateTime.now(),
      ),
    );
  }

  static void remove(String id) {
    GlobalSearchService.instance.remove(id);
  }
}