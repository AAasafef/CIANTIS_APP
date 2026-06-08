import 'package:flutter/material.dart';

class DocumentStorageCard
    extends StatelessWidget {
  final double usedStorage;

  final double totalStorage;

  const DocumentStorageCard({
    super.key,
    required this.usedStorage,
    required this.totalStorage,
  });

  @override
  Widget build(BuildContext context) {
    final progress =
        usedStorage / totalStorage;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(
        22,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          28,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
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
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 54,
                width: 54,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(
                    18,
                  ),
                  color: const Color(
                    0xFFF4EFE8,
                  ),
                ),
                child: const Icon(
                  Icons.storage_outlined,
                  color: Color(
                    0xFF6E5846,
                  ),
                ),
              ),

              const SizedBox(
                width: 16,
              ),

              const Expanded(
                child: Text(
                  'Vault Storage',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight:
                        FontWeight.w500,
                    color: Color(
                      0xFF2D241D,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 24,
          ),

          ClipRRect(
            borderRadius:
                BorderRadius.circular(
              99,
            ),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 12,
              backgroundColor:
                  const Color(
                0xFFF4EFE8,
              ),
              valueColor:
                  const AlwaysStoppedAnimation(
                Color(
                  0xFF2D241D,
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 16,
          ),

          Text(
            '${usedStorage.toStringAsFixed(1)} GB used of ${totalStorage.toStringAsFixed(0)} GB',
            style: TextStyle(
              fontSize: 13,
              color: Colors.black.withOpacity(
                .55,
              ),
            ),
          ),
        ],
      ),
    );
  }
}