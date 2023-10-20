import 'package:flutter/material.dart';

import '../../app/game_controller.dart';
import 'game_screen.dart';

class GameInfo extends StatefulWidget {
  final GameController controller;

  GameInfo(this.controller) : super(key: controller.gameInfoKey);

  @override
  State<StatefulWidget> createState() => GameInfoState();
}

class GameInfoState extends State<GameInfo> {
  GameController get _controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    String text = '';
    if (_controller.gameReady) text = 'Ready!';
    if (_controller.gameEnd) text = 'Game Ended!';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Round: ${_controller.round}',
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          if (_controller.gameLevel != GameLevel.sandbox)
            Text(
              'Points: ${_controller.points}',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          const SizedBox(height: 12.0),
          Text(
            text,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
