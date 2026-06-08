import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class PickedDocumentFile {
  final String name;
  final String savedPath;
  final Uint8List? bytes;
  final bool isWebFile;

  const PickedDocumentFile({
    required this.name,
    required this.savedPath,
    this.bytes,
    required this.isWebFile,
  });
}

class DocumentFileService {
  static final DocumentFileService instance =
      DocumentFileService._internal();

  DocumentFileService._internal();

  final ImagePicker _imagePicker = ImagePicker();

  Future<PickedDocumentFile?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      withData: kIsWeb,
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'doc',
        'docx',
        'jpg',
        'jpeg',
        'png',
        'heic',
        'txt',
        'csv',
        'xlsx',
      ],
    );

    if (result == null || result.files.isEmpty) {
      return null;
    }

    final pickedFile = result.files.single;
    final safeName = _safeFileName(pickedFile.name);

    if (kIsWeb) {
      final bytes = pickedFile.bytes;

      if (bytes == null) {
        return null;
      }

      final base64File = base64Encode(bytes);

      return PickedDocumentFile(
        name: safeName,
        savedPath: 'web_file::$safeName::$base64File',
        bytes: bytes,
        isWebFile: true,
      );
    }

    final filePath = pickedFile.path;

    if (filePath == null || filePath.trim().isEmpty) {
      return null;
    }

    final originalFile = File(filePath);

    if (!await originalFile.exists()) {
      return null;
    }

    final savedFile = await _saveFileLocally(
      originalFile,
      originalName: safeName,
    );

    return PickedDocumentFile(
      name: path.basename(savedFile.path),
      savedPath: savedFile.path,
      isWebFile: false,
    );
  }

  Future<PickedDocumentFile?> scanWithCamera() async {
    final pickedImage = await _imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 92,
    );

    if (pickedImage == null) {
      return null;
    }

    final safeName = _safeFileName(pickedImage.name);

    if (kIsWeb) {
      final bytes = await pickedImage.readAsBytes();
      final base64File = base64Encode(bytes);

      return PickedDocumentFile(
        name: safeName,
        savedPath: 'web_file::$safeName::$base64File',
        bytes: bytes,
        isWebFile: true,
      );
    }

    final imageFile = File(pickedImage.path);

    if (!await imageFile.exists()) {
      return null;
    }

    final savedFile = await _saveFileLocally(
      imageFile,
      originalName: safeName,
    );

    return PickedDocumentFile(
      name: path.basename(savedFile.path),
      savedPath: savedFile.path,
      isWebFile: false,
    );
  }

  Future<File> _saveFileLocally(
    File file, {
    required String originalName,
  }) async {
    final appDirectory = await getApplicationDocumentsDirectory();

    final documentsDirectory = Directory(
      path.join(
        appDirectory.path,
        'ciantis_documents',
      ),
    );

    if (!await documentsDirectory.exists()) {
      await documentsDirectory.create(
        recursive: true,
      );
    }

    final safeOriginalName = _safeFileName(originalName);
    final timeStamp = DateTime.now().microsecondsSinceEpoch.toString();

    final savedPath = path.join(
      documentsDirectory.path,
      '${timeStamp}_$safeOriginalName',
    );

    return file.copy(savedPath);
  }

  String _safeFileName(String fileName) {
    final cleaned = fileName
        .trim()
        .replaceAll(RegExp(r'[\\/:*?"<>|]'), '_')
        .replaceAll(RegExp(r'\s+'), ' ');

    if (cleaned.isEmpty) {
      return 'document';
    }

    return cleaned;
  }

  String detectFileType(String filePathOrName) {
    final cleanValue = filePathOrName.contains('::')
        ? filePathOrName.split('::')[1]
        : filePathOrName;

    final extension = path.extension(cleanValue).toLowerCase();

    switch (extension) {
      case '.pdf':
        return 'pdf';
      case '.doc':
      case '.docx':
        return 'doc';
      case '.jpg':
      case '.jpeg':
      case '.png':
      case '.heic':
        return 'image';
      case '.xlsx':
      case '.csv':
        return 'sheet';
      case '.txt':
        return 'text';
      default:
        return 'file';
    }
  }

  String suggestCategory(String fileName) {
    final lowerName = fileName.toLowerCase();

    if (lowerName.contains('receipt') ||
        lowerName.contains('invoice') ||
        lowerName.contains('payment')) {
      return 'Receipts';
    }

    if (lowerName.contains('warranty')) {
      return 'Warranty Papers';
    }

    if (lowerName.contains('court') ||
        lowerName.contains('legal') ||
        lowerName.contains('lawyer') ||
        lowerName.contains('attorney') ||
        lowerName.contains('ticket') ||
        lowerName.contains('case')) {
      return 'Court/Legal Papers';
    }

    if (lowerName.contains('school') ||
        lowerName.contains('class') ||
        lowerName.contains('syllabus') ||
        lowerName.contains('homework') ||
        lowerName.contains('assignment') ||
        lowerName.contains('quiz') ||
        lowerName.contains('test') ||
        lowerName.contains('exam') ||
        lowerName.contains('study') ||
        lowerName.contains('transcript') ||
        lowerName.contains('financial aid') ||
        lowerName.contains('fafsa') ||
        lowerName.contains('nursing')) {
      return 'School Documents';
    }

    if (lowerName.contains('medical') ||
        lowerName.contains('doctor') ||
        lowerName.contains('lab') ||
        lowerName.contains('prescription') ||
        lowerName.contains('hospital') ||
        lowerName.contains('health')) {
      return 'Medical Records';
    }

    if (lowerName.contains('bill') ||
        lowerName.contains('utility') ||
        lowerName.contains('electric') ||
        lowerName.contains('water') ||
        lowerName.contains('phone') ||
        lowerName.contains('rent')) {
      return 'Bills';
    }

    if (lowerName.contains('tax') ||
        lowerName.contains('irs') ||
        lowerName.contains('1099') ||
        lowerName.contains('w2') ||
        lowerName.contains('w-2')) {
      return 'Tax Documents';
    }

    if (lowerName.contains('business') ||
        lowerName.contains('salon') ||
        lowerName.contains('client') ||
        lowerName.contains('contract') ||
        lowerName.contains('license') ||
        lowerName.contains('course')) {
      return 'Business Documents';
    }

    if (lowerName.contains('kid') ||
        lowerName.contains('child') ||
        lowerName.contains('birth certificate') ||
        lowerName.contains('school form')) {
      return 'Kids Documents';
    }

    if (lowerName.contains('id') ||
        lowerName.contains('license') ||
        lowerName.contains('passport') ||
        lowerName.contains('social security')) {
      return 'Identity Documents';
    }

    return 'Other';
  }
}