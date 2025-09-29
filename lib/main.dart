/// Main entry point for the Metronom app
/// This file initializes the app with Provider state management

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants/theme.dart';
import 'constants/constants.dart';
import 'proxy_providers/pp_metronome.dart';
import 'screens/metronome/l_metronome.dart';
import 'screens/metronome/w_bpm_display.dart';
import 'screens/metronome/w_metronome_controls.dart';
import 'screens/metronome/w_time_signature_selector.dart';

void main() {
  runApp(const MetronomApp());
}

class MetronomApp extends StatelessWidget {
  const MetronomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MetronomeProvider()),
        ChangeNotifierProxyProvider<MetronomeProvider, MetronomeLogic>(
          create: (context) =>
              MetronomeLogic(context.read<MetronomeProvider>()),
          update: (context, provider, previous) =>
              previous ?? MetronomeLogic(provider),
        ),
      ],
      child: MaterialApp(
        title: kAppName,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const MetronomScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MetronomScreen extends StatefulWidget {
  const MetronomScreen({super.key});

  @override
  State<MetronomScreen> createState() => _MetronomScreenState();
}

class _MetronomScreenState extends State<MetronomScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize the metronome logic
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MetronomeLogic>().initialize();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(kAppName),
        centerTitle: true,
        actions: [
          Consumer<MetronomeLogic>(
            builder: (context, logic, child) {
              return IconButton(
                icon: const Icon(Icons.settings),
                onPressed: logic.toggleSettings,
              );
            },
          ),
        ],
      ),
      body: Consumer<MetronomeLogic>(
        builder: (context, logic, child) {
          return Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // BPM Display
                  BpmDisplay(
                    bpm: logic.bpm,
                    onBpmChanged: logic.updateBpm,
                    minBpm: logic.minBpm,
                    maxBpm: logic.maxBpm,
                  ),

                  const SizedBox(height: kDefaultPadding * 2),

                  // Time Signature Display
                  TimeSignatureSelector(
                    timeSignature: logic.timeSignature,
                    onTimeSignatureChanged: logic.updateTimeSignature,
                    availableSignatures: logic.availableTimeSignatures,
                  ),

                  const SizedBox(height: kDefaultPadding * 2),

                  // Current Beat Indicator
                  if (logic.isPlaying) _buildBeatIndicator(context, logic),

                  const SizedBox(height: kDefaultPadding * 2),

                  // Control Buttons
                  MetronomeControls(
                    isPlaying: logic.isPlaying,
                    isInitialized: logic.isInitialized,
                    onPlayPause: logic.togglePlayPause,
                    onStop: logic.stop,
                    isLoading: logic.isLoading,
                  ),

                  const SizedBox(height: kDefaultPadding * 2),

                  // Volume Control
                  if (logic.showSettings) _buildVolumeControl(logic),

                  // Error Display
                  if (logic.errorMessage != null)
                    _buildErrorDisplay(context, logic.errorMessage!),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBeatIndicator(BuildContext context, MetronomeLogic logic) {
    return AnimatedScale(
      scale: logic.isAnimating ? logic.animationScale : 1.0,
      duration: kFastAnimationDuration,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: logic.currentTick == 1
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surface,
          shape: BoxShape.circle,
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            '${logic.currentTick}',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: logic.currentTick == 1
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVolumeControl(MetronomeLogic logic) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          children: [
            Text(
              'Volume: ${logic.formatVolume(logic.volume)}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Slider(
              value: logic.volume,
              min: logic.minVolume,
              max: logic.maxVolume,
              divisions: 100,
              onChanged: logic.updateVolume,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorDisplay(BuildContext context, String errorMessage) {
    return Card(
      color: Theme.of(context).colorScheme.errorContainer,
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Row(
          children: [
            Icon(
              Icons.error_outline,
              color: Theme.of(context).colorScheme.onErrorContainer,
            ),
            const SizedBox(width: kDefaultSpacing),
            Expanded(
              child: Text(
                errorMessage,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onErrorContainer,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
