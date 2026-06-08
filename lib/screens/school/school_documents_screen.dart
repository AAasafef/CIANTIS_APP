import 'package:flutter/material.dart';

import '../../../services/school_documents_service.dart';

import '../../../widgets/school_document_card.dart';

class SchoolDocumentsScreen
    extends StatefulWidget {

  const SchoolDocumentsScreen({
    super.key,
  });

  @override
  State<SchoolDocumentsScreen>
      createState() =>
          _SchoolDocumentsScreenState();
}

class _SchoolDocumentsScreenState
    extends State<
        SchoolDocumentsScreen> {

  final documentsService =
      SchoolDocumentsService
          .instance;

  @override
  Widget build(BuildContext context) {

    final documents =
        documentsService.documents;

    return Scaffold(
      backgroundColor:
          const Color(
        0xFFF4EFE8,
      ),

      floatingActionButton:
          FloatingActionButton(
        backgroundColor:
            const Color(
          0xFF2D241D,
        ),

        elevation: 0,

        onPressed: () {

          _showUploadSheet();
        },

        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
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

                      child: const Icon(
                        Icons.arrow_back,
                        color:
                            Color(
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
                      'School Documents',

                      style: TextStyle(
                        fontSize: 32,

                        fontWeight:
                            FontWeight
                                .w300,

                        letterSpacing:
                            -.8,

                        color:
                            Color(
                          0xFF2D241D,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 16,
              ),

              Text(
                'Scan, organize, and store all school-related documents securely.',
                style: TextStyle(
                  fontSize: 14,

                  color:
                      Colors.black
                          .withOpacity(
                    .58,
                  ),

                  height: 1.6,
                ),
              ),

              const SizedBox(
                height: 28,
              ),

              Expanded(
                child:
                    documents.isEmpty
                        ? _emptyState()
                        : ListView.builder(
                            itemCount:
                                documents
                                    .length,

                            itemBuilder:
                                (
                              context,
                              index,
                            ) {

                              return SchoolDocumentCard(
                                document:
                                    documents[
                                        index],
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emptyState() {

    return Center(
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,

        children: [

          Container(
            height: 90,
            width: 90,

            decoration:
                BoxDecoration(
              shape:
                  BoxShape.circle,

              color:
                  Colors.white,
            ),

            child: const Icon(
              Icons.folder_copy_outlined,

              size: 42,

              color:
                  Color(
                0xFF6E5846,
              ),
            ),
          ),

          const SizedBox(
            height: 28,
          ),

          const Text(
            'No Documents Yet',

            style: TextStyle(
              fontSize: 30,

              fontWeight:
                  FontWeight.w300,

              letterSpacing:
                  -.8,

              color:
                  Color(
                0xFF2D241D,
              ),
            ),
          ),

          const SizedBox(
            height: 14,
          ),

          Text(
            'Upload or scan your first school document to begin organizing your files.',
            textAlign:
                TextAlign.center,

            style: TextStyle(
              fontSize: 14,

              color:
                  Colors.black
                      .withOpacity(
                .58,
              ),

              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  void _showUploadSheet() {

    showModalBottomSheet(
      context: context,

      backgroundColor:
          Colors.transparent,

      isScrollControlled: true,

      builder: (_) {

        return Container(
          padding:
              const EdgeInsets.all(
            24,
          ),

          decoration:
              const BoxDecoration(
            color:
                Color(
              0xFFF8F3EC,
            ),

            borderRadius:
                BorderRadius.vertical(
              top:
                  Radius.circular(
                34,
              ),
            ),
          ),

          child: SafeArea(
            child: Column(
              mainAxisSize:
                  MainAxisSize.min,

              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [

                const Text(
                  'Upload Document',

                  style: TextStyle(
                    fontSize: 28,

                    fontWeight:
                        FontWeight
                            .w300,

                    color:
                        Color(
                      0xFF2D241D,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 12,
                ),

                Text(
                  'Ciantis will later scan and intelligently organize your school documents.',
                  style: TextStyle(
                    fontSize: 14,

                    color:
                        Colors.black
                            .withOpacity(
                      .58,
                    ),

                    height: 1.6,
                  ),
                ),

                const SizedBox(
                  height: 28,
                ),

                _uploadOption(
                  icon:
                      Icons.camera_alt_outlined,

                  title:
                      'Scan Document',

                  subtitle:
                      'Use camera scanner',
                ),

                const SizedBox(
                  height: 16,
                ),

                _uploadOption(
                  icon:
                      Icons.upload_file_outlined,

                  title:
                      'Upload File',

                  subtitle:
                      'PDF, DOC, image, and more',
                ),

                const SizedBox(
                  height: 16,
                ),

                _uploadOption(
                  icon:
                      Icons.auto_awesome_outlined,

                  title:
                      'AI Organize',

                  subtitle:
                      'Automatically categorize documents',
                ),

                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _uploadOption({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {

    return Container(
      padding:
          const EdgeInsets.all(
        18,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(
          24,
        ),
      ),

      child: Row(
        children: [

          Container(
            height: 54,
            width: 54,

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
              icon,

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
                  title,

                  style:
                      const TextStyle(
                    fontSize: 18,

                    fontWeight:
                        FontWeight
                            .w400,

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
                  subtitle,

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
        ],
      ),
    );
  }
}