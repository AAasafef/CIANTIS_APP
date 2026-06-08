import 'package:flutter/material.dart';

import 'screens/dashboard/dashboard_screen.dart';
import 'services/documents_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DocumentsService.instance.initialize();

  runApp(
    const CiantisApp(),
  );
}

class CiantisApp extends StatelessWidget {
  const CiantisApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'ciantis_app',
      debugShowCheckedModeBanner: false,
      title: 'Ciantis',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF4EFE8),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFB08D6D),
        ),
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}