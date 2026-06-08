import 'package:flutter/material.dart';

class DocumentAiProcessingScreen extends StatelessWidget {
  const DocumentAiProcessingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EFE8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4EFE8),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color(0xFF2D241D),
        ),
        title: const Text(
          'AI Processing',
          style: TextStyle(
            color: Color(0xFF2D241D),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: const Center(
        child: Text(
          'AI document processing coming soon.',
          style: TextStyle(
            color: Color(0xFF2D241D),
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}