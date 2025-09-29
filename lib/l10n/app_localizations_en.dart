// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Metronome';

  @override
  String get howToUse => 'How to Use';

  @override
  String get settings => 'Settings';

  @override
  String get play => 'Play';

  @override
  String get pause => 'Pause';

  @override
  String get stop => 'Stop';

  @override
  String get bpm => 'BPM';

  @override
  String get bpmDescription =>
      'Set the tempo. Higher numbers = faster tempo. Use +/- buttons or tap the number to edit.';

  @override
  String get timeSignature => 'Time Signature';

  @override
  String get timeSignatureDescription =>
      'Set how many beats per measure. 4/4 (Common) is most popular, 3/4 (Waltz) for dancing, 2/4 (March) for marching music.';

  @override
  String get beatSubdivision => 'Beat Subdivision';

  @override
  String get beatSubdivisionDescription =>
      'Choose how the beats are divided. Quarter (1/4) is standard, Eighth (1/8) plays twice as fast, Triplet (1/3) creates swing feel, Sixteenth (1/16) is very fast.';

  @override
  String get accentPattern => 'Accent Pattern';

  @override
  String get accentPatternDescription =>
      'Choose which beats are emphasized. Accented beats play louder and help you feel the rhythm structure.';

  @override
  String get metronomeControls => 'Metronome Controls';

  @override
  String get metronomeControlsDescription =>
      'Play/Pause to start or stop the metronome. Stop button resets to beat 1.';

  @override
  String get volume => 'Volume';

  @override
  String get volumeDescription =>
      'Adjust the volume of the metronome. Higher values make the clicks louder.';

  @override
  String get beatIndicator => 'Beat Indicator';

  @override
  String get beatIndicatorDescription =>
      'Shows which beat you\'re currently on. The highlighted circle is the current beat.';

  @override
  String get quarter => 'Quarter';

  @override
  String get eighth => 'Eighth';

  @override
  String get triplet => 'Triplet';

  @override
  String get sixteenth => 'Sixteenth';

  @override
  String get common => 'Common';

  @override
  String get waltz => 'Waltz';

  @override
  String get march => 'March';

  @override
  String get quintuple => 'Quintuple';

  @override
  String get none => 'None';

  @override
  String get firstBeat => 'First Beat';

  @override
  String get strongWeak => 'Strong-Weak';

  @override
  String get custom => 'Custom';

  @override
  String get welcomeToMetronom => 'Welcome to Metronom!';

  @override
  String get welcomeDescription =>
      'Metronom is a professional metronome app designed for musicians of all levels. This guide will help you get started quickly and make the most of all features.';

  @override
  String get quickStart => 'Quick Start (30 seconds)';

  @override
  String get step1 => 'Look at the Beat Indicator';

  @override
  String get step1Description =>
      'The row of circles at the top shows which beat you\'re on. The highlighted circle is the current beat.';

  @override
  String get step2 => 'Press the Play Button';

  @override
  String get step2Description =>
      'Tap the play button (▶️) to start the metronome. You\'ll hear clicks and see the beat indicator move.';

  @override
  String get step3 => 'Adjust the Tempo';

  @override
  String get step3Description =>
      'Use the +/- buttons next to the BPM number to make it faster or slower. BPM means \"beats per minute\".';

  @override
  String get step4 => 'Start Practicing!';

  @override
  String get step4Description =>
      'Play along with the metronome. The visual indicator helps you stay in time.';

  @override
  String get detailedInstructions => 'Detailed Instructions';

  @override
  String get allFeaturesExplained => 'All Features Explained';

  @override
  String get proTips => 'Pro Tips';

  @override
  String get troubleshooting => 'Troubleshooting';

  @override
  String get startSlow => 'Start Slow';

  @override
  String get startSlowDescription =>
      'Begin with a slow tempo (60-80 BPM) and gradually increase speed as you improve.';

  @override
  String get useVisualCues => 'Use Visual Cues';

  @override
  String get useVisualCuesDescription =>
      'Watch the beat indicator to help you stay in time, especially when learning new pieces.';

  @override
  String get practiceSubdivisions => 'Practice Subdivisions';

  @override
  String get practiceSubdivisionsDescription =>
      'Use eighth or sixteenth notes to practice complex rhythms and improve timing.';

  @override
  String get feelTheAccents => 'Feel the Accents';

  @override
  String get feelTheAccentsDescription =>
      'Use accent patterns to understand the musical structure and feel of different time signatures.';

  @override
  String get adjustVolume => 'Adjust Volume';

  @override
  String get adjustVolumeDescription =>
      'Set volume so you can hear the metronome clearly without it overpowering your instrument.';

  @override
  String get noSound => 'No Sound';

  @override
  String get noSoundSolution =>
      'Check your device volume and the app\'s volume setting. Make sure your device isn\'t on silent mode.';

  @override
  String get metronomeWontStart => 'Metronome Won\'t Start';

  @override
  String get metronomeWontStartSolution =>
      'Try stopping and starting again. Make sure you have a valid BPM setting (40-200).';

  @override
  String get visualIndicatorNotMoving => 'Visual Indicator Not Moving';

  @override
  String get visualIndicatorNotMovingSolution =>
      'The visual indicator only moves when the metronome is playing. Press the play button to start.';

  @override
  String get appFeelsSlow => 'App Feels Slow';

  @override
  String get appFeelsSlowSolution =>
      'Close other apps to free up memory. The metronome needs precise timing to work properly.';
}
