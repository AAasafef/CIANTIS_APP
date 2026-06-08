import 'package:flutter/material.dart';

class DocumentActivityScreen
    extends StatelessWidget {
  DocumentActivityScreen({
    super.key,
  });

  final List<Map<String, dynamic>>
      activities = [
    {
      'title':
          'Receipt uploaded',
      'time':
          '2 min ago',
      'icon':
          Icons.receipt_long_outlined,
    },
    {
      'title':
          'Document renamed',
      'time':
          '12 min ago',
      'icon':
          Icons.edit_outlined,
    },
    {
      'title':
          'Cloud backup completed',
      'time':
          '28 min ago',
      'icon':
          Icons.cloud_done_outlined,
    },
    {
      'title':
          'AI categorized tax document',
      'time':
          '1 hr ago',
      'icon':
          Icons.auto_awesome_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF4EFE8),

      appBar: AppBar(
        backgroundColor:
            const Color(0xFFF4EFE8),
        elevation: 0,
        title: const Text(
          'Recent Activity',
          style: TextStyle(
            color: Color(
              0xFF2D241D,
            ),
            fontWeight:
                FontWeight.w400,
          ),
        ),
        iconTheme:
            const IconThemeData(
          color: Color(
            0xFF2D241D,
          ),
        ),
      ),

      body: ListView.builder(
        padding:
            const EdgeInsets.all(20),
        itemCount:
            activities.length,
        itemBuilder:
            (context, index) {
          final activity =
              activities[index];

          return Container(
            margin:
                const EdgeInsets.only(
              bottom: 16,
            ),
            padding:
                const EdgeInsets.all(
              20,
            ),
            decoration:
                BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(
                28,
              ),
            ),
            child: Row(
              children: [
                Container(
                  height: 56,
                  width: 56,
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
                  child: Icon(
                    activity['icon'],
                    color:
                        const Color(
                      0xFF6E5846,
                    ),
                  ),
                ),

                const SizedBox(
                  width: 16,
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                    children: [
                      Text(
                        activity['title'],
                        style:
                            const TextStyle(
                          fontSize: 16,
                          fontWeight:
                              FontWeight
                                  .w500,
                          color:
                              Color(
                            0xFF2D241D,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      Text(
                        activity['time'],
                        style:
                            TextStyle(
                          fontSize: 13,
                          color: Colors
                              .black
                              .withOpacity(
                            .55,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}