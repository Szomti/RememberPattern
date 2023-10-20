import 'package:flutter/material.dart';
import 'package:remember_pattern/app/navigator_extension.dart';

import 'level_select_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<StatefulWidget> createState() => MenuScreenState();
}

class MenuScreenState extends State<MenuScreen> {
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
              _createBtn(
                'Play',
                () => const Navigator().pushNoAnimation(
                  context,
                  (_, __, ___) => const LevelSelectScreen(),
                ),
              ),
              _createBtn('Settings', () {}),
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
              'Remember Patter',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _createBtn(String text, void Function() onPressed) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: onPressed,
              child: Text(text, textAlign: TextAlign.center),
            ),
          ),
        ],
      ),
    );
  }
}
