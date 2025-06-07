import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'photo_messages.dart';

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() => _DiceRollerState();
}

class _DiceRollerState extends State<DiceRoller> {
  final Random _random = Random();
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startRolling();
  }

  void _startRolling() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _currentIndex = _random.nextInt(asterMembers.length);
      });
    });

    Future.delayed(const Duration(seconds: 2), () {
      _timer?.cancel();
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final member = asterMembers[_currentIndex];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black87,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/images/logo.png', width: 40, height: 40),
            const Expanded(
              child: Center(
                child: Text(
                  'Twinkle through the night!',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            Image.asset('assets/images/ASTERISK-ENT-LOGO-1.png',
                width: 40, height: 40),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/aster-member-${_currentIndex + 1}.jpg',
                  width: 350,
                  height: 440,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20),

                // Stage Name (Large)
                Text(
                  member.stageName,
                  style: const TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),

                // Real Name
                Text(
                  member.name,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 8),

                // Role
                Text(
                  member.role,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white60,
                  ),
                ),

                const SizedBox(height: 6),

                // Birthday
                Text(
                  'Birthday: ${member.birthday}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white60,
                  ),
                ),

                const SizedBox(height: 16),

                // Message
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    member.message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Back'),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        _startRolling();
                      },
                      label: const Text('Next'),
                      icon: const Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
