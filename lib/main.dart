/// Metronome App
/// Main entry point for the metronome application

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants/theme.dart';
import 'providers/metronome_provider.dart';
import 'screens/metronome/s_metronome.dart';

void main() {
  runApp(const MetronomeApp());
}

class MetronomeApp extends StatelessWidget {
  const MetronomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => MetronomeProvider())],
      child: MaterialApp(
        title: 'Metronome',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const MetronomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
