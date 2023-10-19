import 'dart:math';

import 'package:flutter/material.dart';

enum GameLevel { easy, normal, hard, sandbox }

class GameScreen extends StatefulWidget {
  final GameLevel gameLevel;

  const GameScreen(this.gameLevel, {super.key});

  @override
  State<StatefulWidget> createState() => GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  static const _buttonsPerRow = 4;
  static const _rowsOfButtons = 4;

  int index = 1;

  GameLevel get _gameLevel => widget.gameLevel;

  @override
  void initState() {
    // Future.delayed(
    //   const Duration(seconds: 2),
    //   () {
    //     final pattern = <int>[];
    //     while (true) {
    //       final num = Random().nextInt(15) + 1;
    //       if (!pattern.contains(num)) continue;
    //       pattern.add(num);
    //       if (pattern.length == _buttonsPerRow * _rowsOfButtons) break;
    //     }
    //     for (final num in pattern) {
    //       Future.delayed(
    //         const Duration(seconds: 1),
    //         () {
    //           // TODO(Szomti): Show pattern, probably will need to get btn as
    //           //  a separate widget with global key
    //         },
    //       );
    //     }
    //   },
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: const Color(0xFF484848),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _createHeader(),
              _createButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createButtons() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < _rowsOfButtons; i++) _createRowOfButtons()
      ],
    );
  }

  Widget _createHeader() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Remember the pattern!',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _createRowOfButtons() {
    return Row(
      children: [for (int j = 0; j < _buttonsPerRow; j++) _createBtn()],
    );
  }

  Widget _createBtn() {
    final num = index;
    index += 1;
    return Expanded(
      child: FittedBox(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: GestureDetector(
            onTap: () {
              // TODO(Szomti): handle press
              debugPrint('$num');
            },
            child: Container(
              decoration: BoxDecoration(
                color: _selectColor(),
                borderRadius: BorderRadius.circular(2.0),
              ),
              child: const SizedBox.square(
                dimension: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _selectColor() {
    switch(_gameLevel){
      case GameLevel.easy:
        return Colors.green;
      case GameLevel.normal:
        return Colors.amber;
      case GameLevel.hard:
        return Colors.redAccent;
      case GameLevel.sandbox:
        return Colors.blueAccent;
    }
  }
}
