import 'package:flutter/material.dart';

import '../models/school_document_model.dart';

class SchoolDocumentCard
    extends StatelessWidget {

  final SchoolDocumentModel document;

  const SchoolDocumentCard({
    super.key,
    required this.document,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      margin:
          const EdgeInsets.only(
        bottom: 16,
      ),

      padding:
          const EdgeInsets.all(
        18,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(
          26,
        ),

        boxShadow: [

          BoxShadow(
            color:
                Colors.black
                    .withOpacity(
              .04,
            ),

            blurRadius: 18,

            offset:
                const Offset(
              0,
              10,
            ),
          ),
        ],
      ),

      child: Row(
        children: [

          Container(
            height: 58,
            width: 58,

            decoration:
                BoxDecoration(
              borderRadius:
                  BorderRadius.circular(
                18,
              ),

              color:
                  const Color(
                0xFFF4EFE8,
              ),
            ),

            child: Icon(
              _icon(),

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
                  document.title,

                  maxLines: 1,

                  overflow:
                      TextOverflow
                          .ellipsis,

                  style:
                      const TextStyle(
                    fontSize: 17,

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
                  height: 6,
                ),

                Text(
                  document.category,

                  style:
                      TextStyle(
                    fontSize: 13,

                    color:
                        Colors.black
                            .withOpacity(
                      .55,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            width: 10,
          ),

          Column(
            children: [

              Text(
                document.fileType
                    .toUpperCase(),

                style:
                    const TextStyle(
                  fontSize: 11,

                  letterSpacing:
                      1.4,

                  color:
                      Color(
                    0xFFB08D6D,
                  ),
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              Icon(
                Icons
                    .arrow_forward_ios_rounded,

                size: 16,

                color:
                    Colors.black
                        .withOpacity(
                  .28,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _icon() {

    switch (
        document.fileType
            .toLowerCase()) {

      case 'pdf':
        return Icons.picture_as_pdf;

      case 'doc':
        return Icons.description;

      case 'image':
        return Icons.image_outlined;

      default:
        return Icons.folder_outlined;
    }
  }
}