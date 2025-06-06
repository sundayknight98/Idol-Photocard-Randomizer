import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';

import 'photo_messages.dart';
import 'home_screen.dart';

final randomizer = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() => _DiceRollerState();
}

class _DiceRollerState extends State<DiceRoller> {
  var currentDiceRoll = 13;
  var message = '';
  var isRevealed = false;
  var isRandomizing = false;

  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void rollDice() {
    setState(() {
      isRandomizing = true;
      isRevealed = false;
    });

    int randomRoll = currentDiceRoll;
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        randomRoll = randomizer.nextInt(12) + 1;
        currentDiceRoll = randomRoll;
      });

      if (timer.tick >= 30) {
        timer.cancel();
        setState(() {
          isRevealed = true;
          isRandomizing = false;
          currentDiceRoll = randomRoll;
          message = getRandomMessage(currentDiceRoll);
        });
        _confettiController.play();
      }
    });
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Overlay
          Container(color: Colors.black.withOpacity(0.4)),
          // Main content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/aster-member-$currentDiceRoll.jpg',
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 30),
                if (!isRandomizing && !isRevealed)
                  const Text(
                    'You ready?',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                if (isRevealed)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      message,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                if (isRevealed)
                  Column(
                    children: [
                      ElevatedButton.icon(
                        onPressed: rollDice,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Try Again'),
                      ),
                      const SizedBox(height: 10),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => const HomeScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.home),
                        label: const Text('Back to Home'),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          // Confetti
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Colors.purple,
                Colors.blue,
                Colors.white,
                Colors.pink,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
