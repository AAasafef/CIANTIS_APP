import 'activity_log_service.dart';

class ActivityHelper {
  ActivityHelper._();

  static Future<void> log({
    required String title,
    required String description,
    required String spaceId,
    required String spaceName,
    required String actionType,
  }) async {
    await ActivityLogService.instance.load();

    await ActivityLogService.instance.addActivity(
      title: title,
      description: description,
      spaceId: spaceId,
      spaceName: spaceName,
      actionType: actionType,
    );
  }

  static Future<void> opened({
    required String title,
    required String description,
    required String spaceId,
    required String spaceName,
  }) async {
    await log(
      title: title,
      description: description,
      spaceId: spaceId,
      spaceName: spaceName,
      actionType: 'opened',
    );
  }

  static Future<void> created({
    required String title,
    required String description,
    required String spaceId,
    required String spaceName,
  }) async {
    await log(
      title: title,
      description: description,
      spaceId: spaceId,
      spaceName: spaceName,
      actionType: 'created',
    );
  }

  static Future<void> updated({
    required String title,
    required String description,
    required String spaceId,
    required String spaceName,
  }) async {
    await log(
      title: title,
      description: description,
      spaceId: spaceId,
      spaceName: spaceName,
      actionType: 'updated',
    );
  }

  static Future<void> deleted({
    required String title,
    required String description,
    required String spaceId,
    required String spaceName,
  }) async {
    await log(
      title: title,
      description: description,
      spaceId: spaceId,
      spaceName: spaceName,
      actionType: 'deleted',
    );
  }

  static Future<void> uploaded({
    required String title,
    required String description,
    required String spaceId,
    required String spaceName,
  }) async {
    await log(
      title: title,
      description: description,
      spaceId: spaceId,
      spaceName: spaceName,
      actionType: 'uploaded',
    );
  }

  static Future<void> completed({
    required String title,
    required String description,
    required String spaceId,
    required String spaceName,
  }) async {
    await log(
      title: title,
      description: description,
      spaceId: spaceId,
      spaceName: spaceName,
      actionType: 'completed',
    );
  }
}