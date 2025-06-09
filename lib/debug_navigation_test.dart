import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/survey_state.dart';
import 'views/survey_form_page.dart';
import 'views/institutionalFormPage.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SurveyState()),
      ],
      child: const DebugApp(),
    ),
  );
}

class DebugApp extends StatelessWidget {
  const DebugApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Debug Navigation',
      home: const DebugHome(),
      routes: {
        '/survey': (context) => const SurveyFormPage(),
        '/institutional': (context) => const InstitutionalFormPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class DebugHome extends StatelessWidget {
  const DebugHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Debug Navigation'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Test de Navegación',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/survey');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
              child: const Text('Ir a Formulario General'),
            ),
            
            const SizedBox(height: 20),
            
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/institutional');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
              child: const Text('Ir DIRECTAMENTE a Formulario Institucional'),
            ),
            
            const SizedBox(height: 20),
            
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const InstitutionalFormPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
              child: const Text('Ir con Navigator.push'),
            ),
          ],
        ),
      ),
    );
  }
}
