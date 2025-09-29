/// Metronome App
/// Main entry point for the metronome application

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'l10n/app_localizations.dart';
import 'constants/theme.dart';
import 'providers/metronome_provider.dart';
import 'providers/locale_provider.dart';
import 'screens/metronome/s_metronome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize locale provider
  final localeProvider = LocaleProvider();
  await localeProvider.initialize();

  runApp(MetronomeApp(localeProvider: localeProvider));
}

class MetronomeApp extends StatelessWidget {
  final LocaleProvider localeProvider;

  const MetronomeApp({super.key, required this.localeProvider});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MetronomeProvider()),
        ChangeNotifierProvider.value(value: localeProvider),
      ],
      child: Consumer<LocaleProvider>(
        builder: (context, localeProvider, child) {
          return MaterialApp(
            title: 'Metronome',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.system,
            home: const MetronomeScreen(),
            debugShowCheckedModeBanner: false,
            locale: localeProvider.currentLocale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: LocaleProvider.supportedLocales,
          );
        },
      ),
    );
  }
}
