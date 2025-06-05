import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'views/splash_screen.dart';
import 'config/theme.dart';
import 'views/surveyFormPage.dart';
import 'views/institutionalFormPage.dart';
import 'views/infrastructureFormPage.dart';
import 'services/storage_service.dart';
import 'services/sync_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Forzar orientación vertical
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Inicializar el almacenamiento local
  await StorageService.init();
  
  // Intentar sincronizar datos pendientes
  await SyncService.syncPendingSurveys();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CENS App',
      theme: AppTheme.light,
      initialRoute: '/',      routes: {
        '/': (context) => const SplashScreen(),
        '/survey': (context) => const SurveyFormPage(),
        '/institutional': (context) => const InstitutionalFormPage(),
        '/infrastructure': (context) => const InfrastructureFormPage(),
      },
    );
  }
}
