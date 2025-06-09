import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'views/splash_screen.dart';
import 'config/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'views/survey_form_page.dart';
import 'views/institutionalFormPage.dart';
import 'views/coverageFormPage.dart';
import 'views/infrastructureFormPage.dart';
import 'views/electricityFormPage.dart';
import 'views/appliancesFormPage.dart';
import 'views/access_route_form_page.dart';
import 'views/photographic_record_page.dart';
import 'views/observationsFormPage.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Forzar orientación vertical
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CENS App',
      theme: AppTheme.light,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],      supportedLocales: const [
        Locale('es', ''),
      ],
      home: const SplashScreen(),
      routes: {
        '/survey': (context) => const SurveyFormPage(),
        '/institutional': (context) => const InstitutionalFormPage(),        '/coverage': (context) => const CoverageFormPage(),
        '/infrastructure': (context) => const InfrastructureFormPage(),
        '/electricity': (context) => const ElectricityFormPage(),        '/appliances': (context) => const AppliancesFormPage(),
        '/access_route': (context) => const AccessRouteFormPage(),
        '/photographic_record': (context) => const PhotographicRecordPage(),
        '/observations': (context) => const ObservationsFormPage(),
      },
    );
  }
}
