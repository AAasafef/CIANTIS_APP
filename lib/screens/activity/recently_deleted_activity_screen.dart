import 'package:flutter/material.dart';

import '../../models/activity_log_item.dart';
import '../../services/activity_log_service.dart';

class RecentlyDeletedActivityScreen extends StatefulWidget {
  const RecentlyDeletedActivityScreen({
    super.key,
  });

  @override
  State<RecentlyDeletedActivityScreen> createState() =>
      _RecentlyDeletedActivityScreenState();
}

class _RecentlyDeletedActivityScreenState
    extends State<RecentlyDeletedActivityScreen> {
  bool loading = true;

  List<ActivityLogItem> deletedItems = [];

  @override
  void initState() {
    super.initState();
    _loadDeleted();
  }

  Future<void> _loadDeleted() async {
    await ActivityLogService.instance.load();

    if (!mounted) return;

    setState(() {
      deletedItems =
          ActivityLogService.instance.deletedItems;
      loading = false;
    });
  }

  Future<void> _restore(String id) async {
    await ActivityLogService.instance.restore(id);
    await _loadDeleted();
  }

  Future<void> _deleteForever(String id) async {
    await ActivityLogService.instance
        .permanentlyDelete(id);
    await _loadDeleted();
  }

  Future<void> _clearDeletedForever() async {
    await ActivityLogService.instance
        .clearDeletedForever();
    await _loadDeleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      body: SafeArea(
        child: loading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF241D18),
                ),
              )
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  24,
                  20,
                  24,
                  40,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 44,
                            width: 44,
                            decoration: BoxDecoration(
                              color:
                                  const Color(0xFFFBF8F4)
                                      .withOpacity(.92),
                              borderRadius:
                                  BorderRadius.circular(15),
                              border: Border.all(
                                color:
                                    const Color(0xFFE2D8CD),
                                width: .7,
                              ),
                            ),
                            child: const Icon(
                              Icons.chevron_left_rounded,
                              color: Color(0xFF241D18),
                              size: 27,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Deleted',
                                style: TextStyle(
                                  fontSize: 42,
                                  height: .98,
                                  fontWeight:
                                      FontWeight.w300,
                                  letterSpacing: -1.4,
                                  color:
                                      Color(0xFF241D18),
                                ),
                              ),
                              SizedBox(height: 9),
                              Text(
                                'RECENT ACTIVITY',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight:
                                      FontWeight.w300,
                                  letterSpacing: 3.2,
                                  color:
                                      Color(0xFF8B7D72),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: _clearDeletedForever,
                          child: Container(
                            height: 44,
                            width: 44,
                            decoration: BoxDecoration(
                              color:
                                  const Color(0xFFFBF8F4)
                                      .withOpacity(.92),
                              borderRadius:
                                  BorderRadius.circular(15),
                              border: Border.all(
                                color:
                                    const Color(0xFFE2D8CD),
                                width: .7,
                              ),
                            ),
                            child: const Icon(
                              Icons.delete_forever_outlined,
                              color: Color(0xFF241D18),
                              size: 22,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 26),

                    if (deletedItems.isEmpty)
                      const _EmptyDeletedActivityState()
                    else
                      Column(
                        children: deletedItems.map((item) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(
                              bottom: 8,
                            ),
                            child: _DeletedActivityTile(
                              item: item,
                              onRestore: () {
                                _restore(item.id);
                              },
                              onDeleteForever: () {
                                _deleteForever(item.id);
                              },
                            ),
                          );
                        }).toList(),
                      ),
                  ],
                ),
              ),
      ),
    );
  }
}

class _EmptyDeletedActivityState extends StatelessWidget {
  const _EmptyDeletedActivityState();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        24,
        34,
        24,
        34,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F4)
            .withOpacity(.88),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: const Color(0xFFE2D8CD),
          width: .7,
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 58,
            width: 58,
            decoration: BoxDecoration(
              color: const Color(0xFFF0E6DB),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.restore_from_trash_outlined,
              color: Color(0xFF8B6F55),
              size: 27,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Nothing deleted',
            style: TextStyle(
              color: Color(0xFF241D18),
              fontSize: 22,
              fontWeight: FontWeight.w300,
              letterSpacing: -.3,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Deleted activity entries will appear here so you can restore them or remove them forever.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF6F6258),
              fontSize: 13,
              fontWeight: FontWeight.w300,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _DeletedActivityTile extends StatelessWidget {
  final ActivityLogItem item;
  final VoidCallback onRestore;
  final VoidCallback onDeleteForever;

  const _DeletedActivityTile({
    required this.item,
    required this.onRestore,
    required this.onDeleteForever,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFBF8F4)
            .withOpacity(.88),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE2D8CD),
          width: .7,
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 34,
            width: 34,
            decoration: BoxDecoration(
              color: const Color(0xFFF0E6DB),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.restore_rounded,
              color: Color(0xFF8B6F55),
              size: 18,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF241D18),
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    letterSpacing: -.1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF6F6258),
                    fontSize: 11,
                    fontWeight: FontWeight.w300,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '${item.spaceName} · Deleted ${_formatTime(item.deletedAt ?? item.createdAt)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Color(0xFF8B7D72),
                    fontSize: 9,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onRestore,
            visualDensity: VisualDensity.compact,
            splashRadius: 18,
            icon: const Icon(
              Icons.restore_rounded,
              size: 18,
              color: Color(0xFF8B6F55),
            ),
          ),
          IconButton(
            onPressed: onDeleteForever,
            visualDensity: VisualDensity.compact,
            splashRadius: 18,
            icon: const Icon(
              Icons.close_rounded,
              size: 18,
              color: Color(0xFF8B7D72),
            ),
          ),
        ],
      ),
    );
  }

  static String _formatTime(DateTime date) {
    final hour = date.hour == 0
        ? 12
        : date.hour > 12
            ? date.hour - 12
            : date.hour;

    final minute = date.minute.toString().padLeft(
          2,
          '0',
        );

    final period = date.hour < 12 ? 'AM' : 'PM';

    return '${date.month}/${date.day}/${date.year} · $hour:$minute $period';
  }
}