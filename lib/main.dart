import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'models/survey_state.dart';
import 'views/splash_screen.dart';
import 'config/theme.dart';
import 'views/survey_form_page.dart';
import 'views/institutionalFormPage.dart';
import 'views/coverageFormPage.dart';
import 'views/infrastructureFormPage.dart';
import 'views/electricityFormPage.dart';
import 'views/appliancesFormPage.dart';
import 'views/access_route_form_page.dart';
import 'views/photographic_record_page.dart';
import 'views/observationsFormPage.dart';
import 'services/storage_service.dart';
// Showcase solo disponible como ruta opcional
import 'form_navigation_showcase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializar Hive
  try {
    await StorageService.init();
    print('Hive inicializado exitosamente');
  } catch (e) {
    print('Error al inicializar Hive: $e');
    // Continuar con la aplicación aunque falle la inicialización
  }
  
  // Forzar orientación vertical
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SurveyState()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {    return MaterialApp(
      title: 'CENS App',
      theme: AppTheme.light,
      home: const SplashScreen(), // Volver a la pantalla normal
      routes: {
        '/showcase': (context) => const FormNavigationShowcase(), // Mover showcase a ruta
        '/survey': (context) => const SurveyFormPage(),
        '/institutional': (context) => const InstitutionalFormPage(),
        '/coverage': (context) => const CoverageFormPage(),
        '/infrastructure': (context) => const InfrastructureFormPage(),
        '/electricity': (context) => const ElectricityFormPage(),
        '/appliances': (context) => const AppliancesFormPage(),
        '/access_route': (context) => const AccessRouteFormPage(),
        '/photographic_record': (context) => const PhotographicRecordPage(),
        '/observations': (context) => const ObservationsFormPage(),
      },
    );
  }
}
