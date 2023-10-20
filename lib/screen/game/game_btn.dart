import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'game_screen.dart';

class GameBtn extends StatefulWidget {
  final int value;
  final GameLevel gameLevel;
  final bool Function(int) currentShow;
  final void Function(int) pressedCallback;

  GameBtn(
    this.value,
    this.gameLevel,
    this.currentShow,
    this.pressedCallback,
  ) : super(key: GameBtnKey(value));

  @override
  State<StatefulWidget> createState() => GameBtnState();
}

class GameBtnState extends State<GameBtn> {
  int get _value => widget.value;

  GameLevel get _gameLevel => widget.gameLevel;

  bool Function(int) get _currentShow => widget.currentShow;

  void Function(int) get _pressedCallback => widget.pressedCallback;

  @override
  Widget build(BuildContext context) {
    final color = _selectColor();
    final result = _currentShow(_value);
    return FittedBox(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: GestureDetector(
          onTap: () => _pressedCallback(_value),
          child: Container(
            decoration: BoxDecoration(
              color: result
                  ? withLightness(color, 0.3)
                  : withLightness(color, 0.6),
              border: result && _gameLevel == GameLevel.hard ? Border.all(
                width: 1.5,
                color: withLightness(color, 0.05),
              ) : Border.all(),
              borderRadius: BorderRadius.circular(2.0),
            ),
            child: const SizedBox.square(
              dimension: 20,
            ),
          ),
        ),
      ),
    );
  }

  Color _selectColor() {
    switch (_gameLevel) {
      case GameLevel.easy:
        return Colors.green;
      case GameLevel.normal:
        return Colors.amber;
      case GameLevel.hard:
        return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
      case GameLevel.sandbox:
        return Colors.blueAccent;
    }
  }

  Color withLightness(Color color, double lightness) {
    return HSLColor.fromColor(color)
        .withLightness(clampDouble(lightness, 0.0, 1.0))
        .toColor();
  }
}

class GameBtnKey extends GlobalObjectKey {
  const GameBtnKey(int super.value);
}
