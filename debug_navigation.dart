import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'lib/models/survey_state.dart';
import 'lib/views/survey_form_page.dart';
import 'lib/views/institutionalFormPage.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SurveyState()),
      ],
      child: MaterialApp(
        home: const NavigationDebugApp(),
        routes: {
          '/survey': (context) => const SurveyFormPage(),
          '/institutional': (context) => const InstitutionalFormPage(),
        },
      ),
    ),
  );
}

class NavigationDebugApp extends StatelessWidget {
  const NavigationDebugApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Debug Navigation')),      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/survey');
              },
              child: const Text('Ir a Formulario 1 (Survey)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/institutional');
              },
              child: const Text('Ir a Formulario 2 (Institutional)'),
            ),
          ],
        ),
      ),
    );
  }
}
