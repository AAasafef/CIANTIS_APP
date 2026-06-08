import 'package:flutter/material.dart';

import '../../widgets/document_import_header.dart';
import '../../widgets/document_import_source_card.dart';

import 'document_scanning_screen.dart';

class DocumentImportSourcesScreen extends StatelessWidget {
  const DocumentImportSourcesScreen({
    super.key,
  });

  void _comingSoon(
    BuildContext context,
    String title,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFF2D241D),
        content: Text(
          '$title coming soon',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFF2D241D),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      'Import Sources',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w300,
                        letterSpacing: -.8,
                        color: Color(0xFF2D241D),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const DocumentImportHeader(),
              const SizedBox(height: 28),
              Text(
                'Import documents into your Ciantis vault from multiple secure sources.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.6,
                  color: Colors.black.withOpacity(.58),
                ),
              ),
              const SizedBox(height: 30),
              DocumentImportSourceCard(
                icon: Icons.camera_alt_outlined,
                title: 'Camera Scanner',
                subtitle: 'Scan physical documents with AI enhancement.',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const DocumentScanningScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              DocumentImportSourceCard(
                icon: Icons.folder_open_outlined,
                title: 'Device Files',
                subtitle: 'Import PDFs, images, and saved files.',
                onTap: () {
                  _comingSoon(
                    context,
                    'Device file import',
                  );
                },
              ),
              const SizedBox(height: 16),
              DocumentImportSourceCard(
                icon: Icons.cloud_outlined,
                title: 'Cloud Drive',
                subtitle: 'Connect Google Drive, Dropbox, and more.',
                onTap: () {
                  _comingSoon(
                    context,
                    'Cloud Drive import',
                  );
                },
              ),
              const SizedBox(height: 16),
              DocumentImportSourceCard(
                icon: Icons.email_outlined,
                title: 'Email Attachments',
                subtitle: 'Import and organize email documents.',
                onTap: () {
                  _comingSoon(
                    context,
                    'Email attachment import',
                  );
                },
              ),
              const SizedBox(height: 16),
              DocumentImportSourceCard(
                icon: Icons.history_outlined,
                title: 'Recent Imports',
                subtitle: 'Quickly access recently imported files.',
                onTap: () {
                  _comingSoon(
                    context,
                    'Recent imports',
                  );
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}