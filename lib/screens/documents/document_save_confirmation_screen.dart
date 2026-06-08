import 'package:flutter/material.dart';

import '../../services/document_file_service.dart';

class DocumentSaveConfirmationScreen extends StatefulWidget {
  final PickedDocumentFile file;
  final String suggestedCategory;
  final String fileType;
  final Future<void> Function(String category) onConfirm;

  const DocumentSaveConfirmationScreen({
    super.key,
    required this.file,
    required this.suggestedCategory,
    required this.fileType,
    required this.onConfirm,
  });

  @override
  State<DocumentSaveConfirmationScreen> createState() =>
      _DocumentSaveConfirmationScreenState();
}

class _DocumentSaveConfirmationScreenState
    extends State<DocumentSaveConfirmationScreen> {
  late String selectedCategory;

  bool isSaving = false;

  final List<String> categories = [
    'Receipts',
    'Warranty Papers',
    'Court/Legal Papers',
    'School Documents',
    'Medical Records',
    'Bills',
    'Tax Documents',
    'Business Documents',
    'Kids Documents',
    'Identity Documents',
    'Other',
  ];

  @override
  void initState() {
    super.initState();

    selectedCategory = categories.contains(widget.suggestedCategory)
        ? widget.suggestedCategory
        : 'Other';
  }

  @override
  Widget build(BuildContext context) {
    final fileName = widget.file.name;

    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      body: SafeArea(
        child: Padding(
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
                    onTap: isSaving
                        ? null
                        : () {
                            Navigator.pop(context, false);
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
                      'Confirm Document',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w300,
                        letterSpacing: -.8,
                        color: Color(0xFF2D241D),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: const Color(0xFFF4EFE8),
                      ),
                      child: Icon(
                        _icon(),
                        color: const Color(0xFF6E5846),
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fileName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF2D241D),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.fileType.toUpperCase(),
                            style: TextStyle(
                              color: Colors.black.withOpacity(.55),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 34),
              const Text(
                'Ciantis thinks this belongs in:',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF2D241D),
                ),
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedCategory,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: categories.map((category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: isSaving
                        ? null
                        : (value) {
                            if (value == null) return;

                            setState(() {
                              selectedCategory = value;
                            });
                          },
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isSaving ? null : _confirmAndSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2D241D),
                    disabledBackgroundColor:
                        const Color(0xFF2D241D).withOpacity(.55),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: isSaving
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Confirm & Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirmAndSave() async {
    if (isSaving) return;

    setState(() {
      isSaving = true;
    });

    try {
      await widget.onConfirm(selectedCategory);

      if (!mounted) return;

      Navigator.pop(context, true);
    } catch (error) {
      if (!mounted) return;

      setState(() {
        isSaving = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFF2D241D),
          content: Text(
            'Save failed: $error',
          ),
        ),
      );
    }
  }

  IconData _icon() {
    switch (widget.fileType.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
        return Icons.description;
      case 'image':
        return Icons.image_outlined;
      case 'sheet':
        return Icons.table_chart_outlined;
      case 'text':
        return Icons.notes_outlined;
      default:
        return Icons.folder_outlined;
    }
  }
}