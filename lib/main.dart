import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'config/theme.dart';
import 'views/splash_screen.dart';
import 'views/surveyFormPage.dart';
import 'views/institutionalFormPage.dart';
import 'views/coverageFormPage.dart';
import 'views/infrastructureFormPage.dart';
import 'views/electricityFormPage.dart';
import 'views/appliancesFormPage.dart';
import 'views/access_route_form_page.dart';
import 'services/storage_service.dart';
import 'services/sync_service.dart';
import 'models/survey_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializar servicios
  await StorageService.init();
  
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
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caracterización CENS',
      theme: AppTheme.light,
      home: const SplashScreen(),
      routes: {
        '/survey': (context) => const SurveyFormPage(),
        '/institutional': (context) => const InstitutionalFormPage(),
        '/coverage': (context) => const CoverageFormPage(),
        '/infrastructure': (context) => const InfrastructureFormPage(),
        '/electricity': (context) => const ElectricityFormPage(),
        '/appliances': (context) => const AppliancesFormPage(),
        '/access_route': (context) => const AccessRouteFormPage(),
      },
    );
  }
}
