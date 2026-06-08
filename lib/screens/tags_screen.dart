import 'package:flutter/material.dart';

import '../../models/tag_item.dart';
import '../../services/tag_service.dart';

class TagsScreen extends StatefulWidget {
  const TagsScreen({
    super.key,
  });

  @override
  State<TagsScreen> createState() =>
      _TagsScreenState();
}

class _TagsScreenState extends State<TagsScreen> {
  bool loading = true;
  List<TagItem> tags = [];

  final TextEditingController controller =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTags();
  }

  Future<void> _loadTags() async {
    await TagService.instance.seedDefaultTags();

    if (!mounted) return;

    setState(() {
      tags = TagService.instance.tags;
      loading = false;
    });
  }

  Future<void> _addTag() async {
    await TagService.instance.addTag(
      controller.text,
    );

    controller.clear();

    await _loadTags();
  }

  Future<void> _deleteTag(String id) async {
    await TagService.instance.deleteTag(id);

    await _loadTags();
  }

  Future<void> _renameTag(
    TagItem tag,
  ) async {
    controller.text = tag.name;

    final result = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return _TagEditSheet(
          controller: controller,
          title: 'Rename Tag',
        );
      },
    );

    if (result == null) {
      controller.clear();
      return;
    }

    await TagService.instance.renameTag(
      id: tag.id,
      newName: result,
    );

    controller.clear();

    await _loadTags();
  }

  Future<void> _showAddSheet() async {
    controller.clear();

    final result = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return _TagEditSheet(
          controller: controller,
          title: 'New Tag',
        );
      },
    );

    if (result == null) {
      controller.clear();
      return;
    }

    controller.text = result;

    await _addTag();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
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
                                'Tags',
                                style: TextStyle(
                                  fontSize: 46,
                                  height: .96,
                                  fontWeight:
                                      FontWeight.w300,
                                  letterSpacing: -1.5,
                                  color:
                                      Color(0xFF241D18),
                                ),
                              ),
                              SizedBox(height: 9),
                              Text(
                                'GLOBAL ORGANIZATION',
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
                          onTap: _showAddSheet,
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
                              Icons.add_rounded,
                              color: Color(0xFF241D18),
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 26),

                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: tags.map((tag) {
                        return GestureDetector(
                          onTap: () {
                            _renameTag(tag);
                          },
                          onLongPress: () {
                            _deleteTag(tag.id);
                          },
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  const Color(0xFFFBF8F4)
                                      .withOpacity(.88),
                              borderRadius:
                                  BorderRadius.circular(20),
                              border: Border.all(
                                color:
                                    const Color(0xFFE2D8CD),
                                width: .7,
                              ),
                            ),
                            child: Text(
                              '#${tag.name}',
                              style: const TextStyle(
                                color: Color(0xFF241D18),
                                fontSize: 13,
                                fontWeight:
                                    FontWeight.w300,
                                letterSpacing: .2,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 28),

                    const Text(
                      'Tap to rename. Hold to delete.',
                      style: TextStyle(
                        color: Color(0xFF8B7D72),
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        letterSpacing: .8,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class _TagEditSheet extends StatelessWidget {
  final TextEditingController controller;
  final String title;

  const _TagEditSheet({
    required this.controller,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(18),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: const Color(0xFFF4EFE8),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF241D18),
                fontSize: 28,
                fontWeight: FontWeight.w300,
                letterSpacing: -.7,
              ),
            ),
            const SizedBox(height: 18),
            Container(
              height: 52,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFFBF8F4),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: const Color(0xFFE2D8CD),
                  width: .7,
                ),
              ),
              child: TextField(
                controller: controller,
                autofocus: true,
                cursorColor: const Color(0xFF241D18),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Tag name',
                  hintStyle: TextStyle(
                    color: Color(0xFF9A8D83),
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            GestureDetector(
              onTap: () {
                Navigator.pop(
                  context,
                  controller.text,
                );
              },
              child: const Text(
                'SAVE TAG',
                style: TextStyle(
                  color: Color(0xFFC6A06B),
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 2.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}