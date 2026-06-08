import 'package:flutter/material.dart';

import '../../services/documents_service.dart';
import '../../widgets/document_empty_folder_card.dart';

class DocumentTrashScreen extends StatefulWidget {
  const DocumentTrashScreen({
    super.key,
  });

  @override
  State<DocumentTrashScreen> createState() =>
      _DocumentTrashScreenState();
}

class _DocumentTrashScreenState
    extends State<DocumentTrashScreen> {
  final DocumentsService documentsService =
      DocumentsService.instance;

  bool changed = false;

  Future<void> _restoreDocument(document) async {
    await documentsService.restoreDocument(document);

    changed = true;

    if (!mounted) return;

    setState(() {});
  }

  Future<void> _deleteForever(document) async {
    await documentsService.permanentlyDeleteDocument(document);

    changed = true;

    if (!mounted) return;

    setState(() {});
  }

  Future<void> _emptyTrash() async {
    await documentsService.emptyTrash();

    changed = true;

    if (!mounted) return;

    setState(() {});
  }

 