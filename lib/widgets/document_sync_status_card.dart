import 'package:flutter/material.dart';

class DocumentSyncStatusCard extends StatelessWidget {
  final bool synced;

  const DocumentSyncStatusCard({
    super.key,
    required this.synced,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(
          28,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withOpacity(
              .04,
            ),
            blurRadius: 18,
            offset: const Offset(
              0,
              10,
            ),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: synced
                  ? const Color(
                      0xFFE8F5EC,
                    )
                  : const Color(
                      0xFFFDF0E7,
                    ),
              borderRadius:
                  BorderRadius.circular(
                18,
              ),
            ),
            child: Icon(
              synced
                  ? Icons.cloud_done_outlined
                  : Icons.cloud_off_outlined,
              color: synced
                  ? const Color(
                      0xFF3E8E5B,
                    )
                  : const Color(
                      0xFFB08D6D,
                    ),
            ),
          ),

          const SizedBox(
            width: 18,
          ),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
              children: [
                Text(
                  synced
                      ? 'Cloud Synced'
                      : 'Offline Mode',
                  style:
                      const TextStyle(
                    fontSize: 18,
                    fontWeight:
                        FontWeight.w500,
                    color: Color(
                      0xFF2D241D,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                Text(
                  synced
                      ? 'Your vault is securely backed up and synced.'
                      : 'Changes will sync automatically once connected.',
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: Colors.black
                        .withOpacity(
                      .55,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration:
                      BoxDecoration(
                    color: synced
                        ? const Color(
                            0xFFE8F5EC,
                          )
                        : const Color(
                            0xFFFDF0E7,
                          ),
                    borderRadius:
                        BorderRadius.circular(
                      999,
                    ),
                  ),
                  child: Text(
                    synced
                        ? 'Protected'
                        : 'Waiting',
                    style:
                        TextStyle(
                      fontSize: 11,
                      fontWeight:
                          FontWeight
                              .w600,
                      color: synced
                          ? const Color(
                              0xFF3E8E5B,
                            )
                          : const Color(
                              0xFFB08D6D,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}