import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:remember_pattern/screen/game/game_screen.dart';

import '../screen/game/game_btn.dart';
import '../screen/game/game_info.dart';

class GameController {
  static const _easyDelayDuration = Duration(milliseconds: 800);
  static const _normalDelayDuration = Duration(milliseconds: 400);
  static const _hardDelayDuration = Duration(milliseconds: 250);
  final List<int> generatedPattern = [];
  final List<int> userPattern = [];
  final GameLevel gameLevel;
  final gameInfoKey = GlobalKey<GameInfoState>();

  GameController(this.gameLevel);

  int round = 0;
  int points = 0;
  int? currentShow;
  bool gameReady = false;
  bool gameEnd = false;
  bool inputDelay = false;

  Future<void> nextRound() async {
    gameReady = false;
    userPattern.clear();
    round++;
    gameInfoKey.currentState?.setState(() {});
    while (true) {
      generatedPattern.add(Random().nextInt(16) + 1);
      if (generatedPattern.length >= round) break;
    }
    for (final num in generatedPattern) {
      await _delay();
      currentShow = num;
      GameBtnKey(num).currentState?.setState(() {});
      await _delay();
      currentShow = null;
      GameBtnKey(num).currentState?.setState(() {});
    }
    gameReady = true;
    gameInfoKey.currentState?.setState(() {});
  }

  void userInput(int value, BuildContext context) {
    userPattern.add(value);
    for (int i = 0; i < userPattern.length; i++) {
      if (userPattern.elementAt(i) != generatedPattern.elementAt(i)) {
        gameEnd = true;
        Navigator.pop(context);
        return;
      }
    }
    if (userPattern.length != generatedPattern.length) return;
    points += (5 * gameLevel.multiplier);
    nextRound();
  }

  Future<void> _delay() async {
    switch (gameLevel) {
      case GameLevel.easy:
        await Future.delayed(_easyDelayDuration);
      case GameLevel.normal:
        await Future.delayed(_normalDelayDuration);
      case GameLevel.hard:
        await Future.delayed(_hardDelayDuration);
      case GameLevel.sandbox:
        await Future.delayed(_easyDelayDuration);
    }
  }
}
