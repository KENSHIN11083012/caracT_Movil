import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/survey_state.dart';
import 'views/institutionalFormPage.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SurveyState()),
      ],      child: const MaterialApp(
        title: 'Test Institutional Form',
        home: InstitutionalFormPage(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
