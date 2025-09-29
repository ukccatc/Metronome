import 'package:flutter/material.dart';
import 'package:metronome/metronome.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

void main() {
  runApp(const MetronomApp());
}

class MetronomApp extends StatelessWidget {
  const MetronomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Metronom',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MetronomScreen(),
    );
  }
}

class MetronomScreen extends StatefulWidget {
  const MetronomScreen({super.key});

  @override
  State<MetronomScreen> createState() => _MetronomScreenState();
}

class _MetronomScreenState extends State<MetronomScreen> {
  final Metronome _metronome = Metronome();
  final AudioPlayer _audioPlayer = AudioPlayer();
  Timer? _metronomeTimer;
  bool _isPlaying = false;
  bool _isInitialized = false;
  bool _useFallback = false;
  int _bpm = 120;
  double _volume = 50.0;
  int _timeSignature = 4;
  int _currentTick = 0;

  @override
  void initState() {
    super.initState();
    _initializeMetronome();
  }

  Future<void> _initializeMetronome() async {
    try {
      debugPrint('Initializing metronome...');
      await _metronome.init(
        'assets/audio/snare.wav',
        accentedPath: 'assets/audio/claves44_wav.wav',
        bpm: _bpm,
        volume: _volume.toInt(),
        enableTickCallback: true,
        timeSignature: _timeSignature,
        sampleRate: 44100,
      );

      debugPrint('Metronome initialized successfully');

      // Listen to tick stream
      _metronome.tickStream.listen((int tick) {
        debugPrint('Tick: $tick');
        setState(() {
          _currentTick = tick;
        });
      });

      setState(() {
        _isInitialized = true;
        _useFallback = false;
      });
      debugPrint('Metronome ready to play');
    } catch (e) {
      debugPrint('Error initializing metronome: $e');
      debugPrint('Switching to fallback audio system...');
      setState(() {
        _isInitialized = true;
        _useFallback = true;
      });
    }
  }

  void _togglePlayPause() {
    if (!_isInitialized) {
      debugPrint('Metronome not initialized, cannot play');
      return;
    }

    if (_isPlaying) {
      debugPrint('Pausing metronome');
      if (_useFallback) {
        _metronomeTimer?.cancel();
      } else {
        _metronome.pause();
      }
    } else {
      debugPrint('Starting metronome');
      if (_useFallback) {
        _startFallbackMetronome();
      } else {
        _metronome.play();
      }
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _startFallbackMetronome() {
    debugPrint('Starting fallback metronome at $_bpm BPM');
    final interval = Duration(milliseconds: (60000 / _bpm).round());
    _currentTick = 0;

    _metronomeTimer = Timer.periodic(interval, (timer) {
      setState(() {
        _currentTick = (_currentTick % _timeSignature) + 1;
      });

      // Play different sounds for beat 1 vs other beats
      if (_currentTick == 1) {
        _audioPlayer.play(AssetSource('audio/claves44_wav.wav'));
      } else {
        _audioPlayer.play(AssetSource('audio/snare.wav'));
      }

      debugPrint('Fallback tick: $_currentTick');
    });
  }

  void _stop() {
    if (!_isInitialized) return;

    if (_useFallback) {
      _metronomeTimer?.cancel();
    } else {
      _metronome.stop();
    }
    setState(() {
      _isPlaying = false;
      _currentTick = 0;
    });
  }

  void _setBPM(double value) {
    setState(() {
      _bpm = value.round();
    });
    if (_isInitialized) {
      _metronome.setBPM(_bpm);
    }
  }

  void _setVolume(double value) {
    setState(() {
      _volume = value;
    });
    if (_isInitialized) {
      _metronome.setVolume(_volume.toInt());
    }
  }

  void _setTimeSignature(int value) {
    setState(() {
      _timeSignature = value;
    });
    if (_isInitialized) {
      _metronome.setTimeSignature(_timeSignature);
    }
  }

  @override
  void dispose() {
    _metronomeTimer?.cancel();
    _metronome.destroy();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Metronom'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // BPM Display
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Text('BPM', style: Theme.of(context).textTheme.titleMedium),
                    Text(
                      '$_bpm',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Time Signature Display
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      'Time Signature',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      '$_timeSignature/4',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Current Beat Indicator
              if (_isPlaying)
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: _currentTick == 1
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.surface,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outline,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '$_currentTick',
                      style:
                          Theme.of(context).textTheme.headlineLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: _currentTick == 1
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Theme.of(context).colorScheme.onSurface,
                              ),
                    ),
                  ),
                ),

              const SizedBox(height: 32),

              // Control Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Play/Pause Button
                  ElevatedButton.icon(
                    onPressed: _isInitialized ? _togglePlayPause : null,
                    icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                    label: Text(_isPlaying ? 'Pause' : 'Play'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),

                  // Stop Button
                  ElevatedButton.icon(
                    onPressed: _isInitialized && _isPlaying ? _stop : null,
                    icon: const Icon(Icons.stop),
                    label: const Text('Stop'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // BPM Slider
              Column(
                children: [
                  Text(
                    'BPM: $_bpm',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Slider(
                    value: _bpm.toDouble(),
                    min: 40,
                    max: 200,
                    divisions: 160,
                    onChanged: _setBPM,
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Volume Slider
              Column(
                children: [
                  Text(
                    'Volume: ${_volume.round()}%',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Slider(
                    value: _volume,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    onChanged: _setVolume,
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Time Signature Selector
              Column(
                children: [
                  Text(
                    'Time Signature: $_timeSignature/4',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    alignment: WrapAlignment.center,
                    children: [2, 3, 4, 5, 6, 7, 8].map((signature) {
                      return ChoiceChip(
                        label: Text('$signature/4'),
                        selected: _timeSignature == signature,
                        onSelected: (selected) {
                          if (selected) {
                            _setTimeSignature(signature);
                          }
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
