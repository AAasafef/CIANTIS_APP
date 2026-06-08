import 'package:flutter/material.dart';

import '../../widgets/document_scan_animation_card.dart';

class DocumentScanningScreen
    extends StatelessWidget {
  const DocumentScanningScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF4EFE8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
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
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(
                          18,
                        ),
                      ),
                      child: const Icon(
                        Icons.close,
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
                      'AI Scanner',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight:
                            FontWeight.w300,
                        letterSpacing: -.8,
                        color: Color(
                          0xFF2D241D,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 40,
              ),

              const DocumentScanAnimationCard(),

              const SizedBox(
                height: 32,
              ),

              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.all(
                  22,
                ),
                decoration:
                    BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(
                    28,
                  ),
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [
                    const Text(
                      'Live Scanner Features',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight:
                            FontWeight.w500,
                        color: Color(
                          0xFF2D241D,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 18,
                    ),

                    _feature(
                      Icons.auto_fix_high,
                      'Auto edge detection',
                    ),

                    _feature(
                      Icons
                          .document_scanner_outlined,
                      'Document enhancement',
                    ),

                    _feature(
                      Icons.sort_outlined,
                      'AI smart categorization',
                    ),

                    _feature(
                      Icons.lock_outline,
                      'Secure encrypted storage',
                    ),

                    _feature(
                      Icons.search_outlined,
                      'OCR text recognition',
                    ),

                    _feature(
                      Icons.folder_copy_outlined,
                      'Auto folder suggestions',
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.all(
                  22,
                ),
                decoration:
                    BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(
                    28,
                  ),
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: const [
                    Text(
                      'Supported Documents',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.w500,
                        color: Color(
                          0xFF2D241D,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      'Receipts',
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Medical Records',
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'School Documents',
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Tax Documents',
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Business Documents',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _feature(
    IconData icon,
    String title,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16,
      ),
      child: Row(
        children: [
          Container(
            height: 44,
            width: 44,
            decoration:
                BoxDecoration(
              color: const Color(
                0xFFF4EFE8,
              ),
              borderRadius:
                  BorderRadius.circular(
                14,
              ),
            ),
            child: Icon(
              icon,
              size: 20,
              color: const Color(
                0xFF6E5846,
              ),
            ),
          ),
          const SizedBox(
            width: 14,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              color: Color(
                0xFF2D241D,
              ),
            ),
          ),
        ],
      ),
    );
  }
}