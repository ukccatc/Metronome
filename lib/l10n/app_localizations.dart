import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Metronome'**
  String get appTitle;

  /// Title for the FAQ/help screen
  ///
  /// In en, this message translates to:
  /// **'How to Use'**
  String get howToUse;

  /// Settings button and screen title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Play button text
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get play;

  /// Pause button text
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pause;

  /// Stop button text
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stop;

  /// Beats per minute label
  ///
  /// In en, this message translates to:
  /// **'BPM'**
  String get bpm;

  /// Description for BPM control
  ///
  /// In en, this message translates to:
  /// **'Set the tempo. Higher numbers = faster tempo. Use +/- buttons or tap the number to edit.'**
  String get bpmDescription;

  /// Time signature label
  ///
  /// In en, this message translates to:
  /// **'Time Signature'**
  String get timeSignature;

  /// Description for time signature control
  ///
  /// In en, this message translates to:
  /// **'Set how many beats per measure. 4/4 (Common) is most popular, 3/4 (Waltz) for dancing, 2/4 (March) for marching music.'**
  String get timeSignatureDescription;

  /// Beat subdivision label
  ///
  /// In en, this message translates to:
  /// **'Beat Subdivision'**
  String get beatSubdivision;

  /// Description for beat subdivision control
  ///
  /// In en, this message translates to:
  /// **'Choose how the beats are divided. Quarter (1/4) is standard, Eighth (1/8) plays twice as fast, Triplet (1/3) creates swing feel, Sixteenth (1/16) is very fast.'**
  String get beatSubdivisionDescription;

  /// Accent pattern label
  ///
  /// In en, this message translates to:
  /// **'Accent Pattern'**
  String get accentPattern;

  /// Description for accent pattern control
  ///
  /// In en, this message translates to:
  /// **'Choose which beats are emphasized. Accented beats play louder and help you feel the rhythm structure.'**
  String get accentPatternDescription;

  /// Metronome controls section title
  ///
  /// In en, this message translates to:
  /// **'Metronome Controls'**
  String get metronomeControls;

  /// Description for metronome controls
  ///
  /// In en, this message translates to:
  /// **'Play/Pause to start or stop the metronome. Stop button resets to beat 1.'**
  String get metronomeControlsDescription;

  /// Volume control label
  ///
  /// In en, this message translates to:
  /// **'Volume'**
  String get volume;

  /// Description for volume control
  ///
  /// In en, this message translates to:
  /// **'Adjust the volume of the metronome. Higher values make the clicks louder.'**
  String get volumeDescription;

  /// Beat indicator section title
  ///
  /// In en, this message translates to:
  /// **'Beat Indicator'**
  String get beatIndicator;

  /// Description for beat indicator
  ///
  /// In en, this message translates to:
  /// **'Shows which beat you\'re currently on. The highlighted circle is the current beat.'**
  String get beatIndicatorDescription;

  /// Quarter note subdivision
  ///
  /// In en, this message translates to:
  /// **'Quarter'**
  String get quarter;

  /// Eighth note subdivision
  ///
  /// In en, this message translates to:
  /// **'Eighth'**
  String get eighth;

  /// Triplet subdivision
  ///
  /// In en, this message translates to:
  /// **'Triplet'**
  String get triplet;

  /// Sixteenth note subdivision
  ///
  /// In en, this message translates to:
  /// **'Sixteenth'**
  String get sixteenth;

  /// Common time signature name
  ///
  /// In en, this message translates to:
  /// **'Common'**
  String get common;

  /// Waltz time signature name
  ///
  /// In en, this message translates to:
  /// **'Waltz'**
  String get waltz;

  /// March time signature name
  ///
  /// In en, this message translates to:
  /// **'March'**
  String get march;

  /// Quintuple time signature name
  ///
  /// In en, this message translates to:
  /// **'Quintuple'**
  String get quintuple;

  /// No accent pattern
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// First beat accent pattern
  ///
  /// In en, this message translates to:
  /// **'First Beat'**
  String get firstBeat;

  /// Strong-weak accent pattern
  ///
  /// In en, this message translates to:
  /// **'Strong-Weak'**
  String get strongWeak;

  /// Custom accent pattern
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get custom;

  /// Welcome message in FAQ
  ///
  /// In en, this message translates to:
  /// **'Welcome to Metronom!'**
  String get welcomeToMetronom;

  /// Welcome description in FAQ
  ///
  /// In en, this message translates to:
  /// **'Metronom is a professional metronome app designed for musicians of all levels. This guide will help you get started quickly and make the most of all features.'**
  String get welcomeDescription;

  /// Quick start section title
  ///
  /// In en, this message translates to:
  /// **'Quick Start (30 seconds)'**
  String get quickStart;

  /// Quick start step 1
  ///
  /// In en, this message translates to:
  /// **'Look at the Beat Indicator'**
  String get step1;

  /// Quick start step 1 description
  ///
  /// In en, this message translates to:
  /// **'The row of circles at the top shows which beat you\'re on. The highlighted circle is the current beat.'**
  String get step1Description;

  /// Quick start step 2
  ///
  /// In en, this message translates to:
  /// **'Press the Play Button'**
  String get step2;

  /// Quick start step 2 description
  ///
  /// In en, this message translates to:
  /// **'Tap the play button (▶️) to start the metronome. You\'ll hear clicks and see the beat indicator move.'**
  String get step2Description;

  /// Quick start step 3
  ///
  /// In en, this message translates to:
  /// **'Adjust the Tempo'**
  String get step3;

  /// Quick start step 3 description
  ///
  /// In en, this message translates to:
  /// **'Use the +/- buttons next to the BPM number to make it faster or slower. BPM means \"beats per minute\".'**
  String get step3Description;

  /// Quick start step 4
  ///
  /// In en, this message translates to:
  /// **'Start Practicing!'**
  String get step4;

  /// Quick start step 4 description
  ///
  /// In en, this message translates to:
  /// **'Play along with the metronome. The visual indicator helps you stay in time.'**
  String get step4Description;

  /// Detailed instructions section title
  ///
  /// In en, this message translates to:
  /// **'Detailed Instructions'**
  String get detailedInstructions;

  /// All features explained section title
  ///
  /// In en, this message translates to:
  /// **'All Features Explained'**
  String get allFeaturesExplained;

  /// Pro tips section title
  ///
  /// In en, this message translates to:
  /// **'Pro Tips'**
  String get proTips;

  /// Troubleshooting section title
  ///
  /// In en, this message translates to:
  /// **'Troubleshooting'**
  String get troubleshooting;

  /// Pro tip: start slow
  ///
  /// In en, this message translates to:
  /// **'Start Slow'**
  String get startSlow;

  /// Pro tip: start slow description
  ///
  /// In en, this message translates to:
  /// **'Begin with a slow tempo (60-80 BPM) and gradually increase speed as you improve.'**
  String get startSlowDescription;

  /// Pro tip: use visual cues
  ///
  /// In en, this message translates to:
  /// **'Use Visual Cues'**
  String get useVisualCues;

  /// Pro tip: use visual cues description
  ///
  /// In en, this message translates to:
  /// **'Watch the beat indicator to help you stay in time, especially when learning new pieces.'**
  String get useVisualCuesDescription;

  /// Pro tip: practice subdivisions
  ///
  /// In en, this message translates to:
  /// **'Practice Subdivisions'**
  String get practiceSubdivisions;

  /// Pro tip: practice subdivisions description
  ///
  /// In en, this message translates to:
  /// **'Use eighth or sixteenth notes to practice complex rhythms and improve timing.'**
  String get practiceSubdivisionsDescription;

  /// Pro tip: feel the accents
  ///
  /// In en, this message translates to:
  /// **'Feel the Accents'**
  String get feelTheAccents;

  /// Pro tip: feel the accents description
  ///
  /// In en, this message translates to:
  /// **'Use accent patterns to understand the musical structure and feel of different time signatures.'**
  String get feelTheAccentsDescription;

  /// Pro tip: adjust volume
  ///
  /// In en, this message translates to:
  /// **'Adjust Volume'**
  String get adjustVolume;

  /// Pro tip: adjust volume description
  ///
  /// In en, this message translates to:
  /// **'Set volume so you can hear the metronome clearly without it overpowering your instrument.'**
  String get adjustVolumeDescription;

  /// Troubleshooting: no sound
  ///
  /// In en, this message translates to:
  /// **'No Sound'**
  String get noSound;

  /// Troubleshooting: no sound solution
  ///
  /// In en, this message translates to:
  /// **'Check your device volume and the app\'s volume setting. Make sure your device isn\'t on silent mode.'**
  String get noSoundSolution;

  /// Troubleshooting: metronome won't start
  ///
  /// In en, this message translates to:
  /// **'Metronome Won\'t Start'**
  String get metronomeWontStart;

  /// Troubleshooting: metronome won't start solution
  ///
  /// In en, this message translates to:
  /// **'Try stopping and starting again. Make sure you have a valid BPM setting (40-200).'**
  String get metronomeWontStartSolution;

  /// Troubleshooting: visual indicator not moving
  ///
  /// In en, this message translates to:
  /// **'Visual Indicator Not Moving'**
  String get visualIndicatorNotMoving;

  /// Troubleshooting: visual indicator not moving solution
  ///
  /// In en, this message translates to:
  /// **'The visual indicator only moves when the metronome is playing. Press the play button to start.'**
  String get visualIndicatorNotMovingSolution;

  /// Troubleshooting: app feels slow
  ///
  /// In en, this message translates to:
  /// **'App Feels Slow'**
  String get appFeelsSlow;

  /// Troubleshooting: app feels slow solution
  ///
  /// In en, this message translates to:
  /// **'Close other apps to free up memory. The metronome needs precise timing to work properly.'**
  String get appFeelsSlowSolution;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
