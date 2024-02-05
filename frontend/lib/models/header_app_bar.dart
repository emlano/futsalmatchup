import 'package:flutter/material.dart';
import 'package:frontend/resources/icon_fonts.dart';

class TitleAppBar extends AppBar {
  TitleAppBar({super.key}) : super(
    backgroundColor: Colors.white,
    foregroundColor: Colors.teal,
    leading: const Icon(
        IconFont.soccerBall,
        size: 35,
    ),
    title: const Text(
        "Futsal MatchUp",
        style: TextStyle(
          fontFamily: 'DancingScript',
          fontWeight: FontWeight.bold,
          fontSize: 34
        ),
    ),
    centerTitle: true,
  );
}