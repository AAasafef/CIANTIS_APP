import 'package:flutter/material.dart';

import '../../models/search_result_item.dart';

import '../../services/global_search_service.dart';

class GlobalSearchScreen extends StatefulWidget {
  const GlobalSearchScreen({
    super.key,
  });

  @override
  State<GlobalSearchScreen> createState() =>
      _GlobalSearchScreenState();
}

class _GlobalSearchScreenState
    extends State<GlobalSearchScreen> {
  final TextEditingController
      searchController =
      TextEditingController();

  final GlobalSearchService
      searchService =
      GlobalSearchService.instance;

  String query = '';

  @override
  Widget build(BuildContext context) {
    final results =
        searchService.search(query);

    return Scaffold(
      backgroundColor:
          const Color(0xFFF4EFE8),

      body: SafeArea(
        child:
            SingleChildScrollView(
          physics:
              const BouncingScrollPhysics(),
          padding:
              const EdgeInsets.fromLTRB(
            24,
            20,
            24,
            40,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment
                    .start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(
                        context,
                      );
                    },
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration:
                          BoxDecoration(
                        color:
                            Colors.white,
                        borderRadius:
                            BorderRadius.circular(
                          18,
                        ),
                      ),
                      child:
                          const Icon(
                        Icons
                            .arrow_back,
                        color: Color(
                          0xFF2D241D,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 16,
                  ),

                  const Expanded(
                    child: Text(
                      'Search',
                      style:
                          TextStyle(
                        fontSize:
                            40,
                        fontWeight:
                            FontWeight
                                .w300,
                        letterSpacing:
                            -1,
                        color: Color(
                          0xFF2D241D,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 26,
              ),

              Container(
                decoration:
                    BoxDecoration(
                  color:
                      Colors.white,
                  borderRadius:
                      BorderRadius.circular(
                    24,
                  ),
                ),
                child: TextField(
                  controller:
                      searchController,
                  cursorColor:
                      const Color(
                    0xFF2D241D,
                  ),
                  onChanged: (
                    value,
                  ) {
                    setState(() {
                      query =
                          value;
                    });
                  },
                  decoration:
                      InputDecoration(
                    hintText:
                        'Search notes, documents, files...',
                    hintStyle:
                        TextStyle(
                      color: Colors
                          .black
                          .withOpacity(
                        .35,
                      ),
                    ),
                    border:
                        InputBorder.none,
                    contentPadding:
                        const EdgeInsets.symmetric(
                      horizontal:
                          20,
                      vertical:
                          18,
                    ),
                    prefixIcon:
                        const Icon(
                      Icons.search,
                      color: Color(
                        0xFF8B7D72,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 28,
              ),

              if (results.isEmpty)
                const _EmptySearchState()
              else
                Column(
                  children:
                      results.map(
                    (
                      result,
                    ) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(
                          bottom: 12,
                        ),
                        child:
                            _SearchResultTile(
                          result:
                              result,
                        ),
                      );
                    },
                  ).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptySearchState
    extends StatelessWidget {
  const _EmptySearchState();

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.all(
        30,
      ),
      decoration: BoxDecoration(
        color: Colors.white
            .withOpacity(.9),
        borderRadius:
            BorderRadius.circular(
          28,
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration:
                BoxDecoration(
              color:
                  const Color(
                0xFFF4EFE8,
              ),
              borderRadius:
                  BorderRadius.circular(
                18,
              ),
            ),
            child: const Icon(
              Icons.search,
              color: Color(
                0xFF6E5846,
              ),
            ),
          ),

          const SizedBox(
            height: 18,
          ),

          const Text(
            'Nothing found',
            style: TextStyle(
              color:
                  Color(
                0xFF2D241D,
              ),
              fontSize: 22,
              fontWeight:
                  FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchResultTile
    extends StatelessWidget {
  final SearchResultItem result;

  const _SearchResultTile({
    required this.result,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.all(
        18,
      ),
      decoration: BoxDecoration(
        color: Colors.white
            .withOpacity(.92),
        borderRadius:
            BorderRadius.circular(
          24,
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration:
                BoxDecoration(
              color:
                  const Color(
                0xFFF4EFE8,
              ),
              borderRadius:
                  BorderRadius.circular(
                16,
              ),
            ),
            child: Icon(
              _iconForType(
                result
                    .sourceType,
              ),
              color:
                  const Color(
                0xFF6E5846,
              ),
            ),
          ),

          const SizedBox(
            width: 14,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
              children: [
                Text(
                  result.title,
                  maxLines: 1,
                  overflow:
                      TextOverflow
                          .ellipsis,
                  style:
                      const TextStyle(
                    color: Color(
                      0xFF2D241D,
                    ),
                    fontSize: 16,
                    fontWeight:
                        FontWeight
                            .w400,
                  ),
                ),

                const SizedBox(
                  height: 4,
                ),

                Text(
                  result.subtitle,
                  maxLines: 1,
                  overflow:
                      TextOverflow
                          .ellipsis,
                  style:
                      TextStyle(
                    color: Colors
                        .black
                        .withOpacity(
                      .5,
                    ),
                    fontSize: 12,
                    fontWeight:
                        FontWeight
                            .w300,
                  ),
                ),

                const SizedBox(
                  height: 5,
                ),

                Text(
                  result.spaceName
                      .toUpperCase(),
                  style:
                      const TextStyle(
                    color: Color(
                      0xFFB08D6D,
                    ),
                    fontSize: 9,
                    letterSpacing:
                        1.8,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static IconData
      _iconForType(
    String type,
  ) {
    switch (type) {
      case 'note':
        return Icons
            .edit_note_rounded;

      case 'document':
        return Icons
            .description_outlined;

      default:
        return Icons
            .search_rounded;
    }
  }
}