import 'package:flutter/material.dart';

import '../../app/game_controller.dart';
import 'game_btn.dart';
import 'game_info.dart';

enum GameLevel {
  easy._(1),
  normal._(2),
  hard._(3),
  sandbox._(0);

  final int multiplier;

  const GameLevel._(this.multiplier);
}

class GameScreen extends StatefulWidget {
  final GameLevel gameLevel;
  final GameController controller;

  GameScreen(this.gameLevel, {super.key})
      : controller = GameController(gameLevel);

  @override
  State<StatefulWidget> createState() => GameScreenState();
}

class GameScreenState extends State<GameScreen> {
  static const _buttonsPerRow = 4;
  static const _rowsOfButtons = 4;

  int index = 1;

  GameController get _controller => widget.controller;

  int? get currentShow => _controller.currentShow;

  set currentShow(int? value) => _controller.currentShow = value;

  bool get gameReady => _controller.gameReady;

  bool get inputDelay => _controller.inputDelay;

  set inputDelay(bool value) => _controller.inputDelay = value;

  GameLevel get _gameLevel => widget.gameLevel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.endOfFrame.then(
      (_) {
        if (mounted) _controller.nextRound();
      },
    );
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
              GameInfo(_controller),
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _gameLevel.name.toUpperCase(),
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          const Row(
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
      child: GameBtn(
        num,
        _gameLevel,
        (value) => value == currentShow,
        _onPressed,
      ),
    );
  }

  void _onPressed(int value) async {
    if (!gameReady || inputDelay) return;
    inputDelay = true;
    currentShow = value;
    GameBtnKey(value).currentState?.setState(() {});
    await Future.delayed(const Duration(milliseconds: 200));
    currentShow = null;
    if (!mounted) return;
    _controller.userInput(value, context);
    GameBtnKey(value).currentState?.setState(() {});
    await Future.delayed(const Duration(milliseconds: 10));
    inputDelay = false;
  }
}
