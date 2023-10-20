import 'package:flutter/material.dart';
import 'package:remember_pattern/app/navigator_extension.dart';

import 'game/game_screen.dart';

class LevelSelectScreen extends StatefulWidget {
  const LevelSelectScreen({super.key});

  @override
  State<StatefulWidget> createState() => LevelSelectScreenState();
}

class LevelSelectScreenState extends State<LevelSelectScreen> {
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
              _createBtn('Easy', GameLevel.easy),
              _createBtn('Normal', GameLevel.normal),
              _createBtn('Hard', GameLevel.hard),
              _createBtn('Sandbox', GameLevel.sandbox),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createHeader() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Select the level',
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

  Widget _createBtn(String text, GameLevel gameLevel) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () => const Navigator().pushNoAnimation(
                context,
                (_, __, ___) => GameScreen(gameLevel),
              ),
              child: Text(text, textAlign: TextAlign.center),
            ),
          ),
        ],
      ),
    );
  }
}
