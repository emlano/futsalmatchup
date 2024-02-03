import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:frontend/IconFonts/IconFonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.title});

  final String title;

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.teal,
          centerTitle: true,
          title: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              letterSpacing: 0,
              wordSpacing: 5,
              fontFamily: 'DancingScript',
            ),
          ),
          leading: const Icon(
            IconFont.soccer_ball,
            size: 35,
          )),
      body: Column(children: [
        const SizedBox(
          height: 50,
        ),
        CarouselSlider(
          options: CarouselOptions(
              height: 300,
              autoPlay: true,
              autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
              enlargeCenterPage: true,
              enlargeFactor: 1),
          items: [0, 1, 2].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Column(
                    children: [
                      CarouselData.images[i],
                      const SizedBox(height: 10),
                      CarouselData.texts[i]
                    ],
                  ),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 25),
      ]),
    );
  }
}

class CarouselData {
  static final List<Image> images = [
    'assets/images/img1.jpg',
    'assets/images/img2.png',
    'assets/images/img3.png'
  ].map((i) {
    return Image.asset(
      i,
      width: 200,
      height: 200,
    );
  }).toList();

  static final List<Text> texts =
      ['Find Players', 'Find Stadiums', 'Play Futsal'].map((i) {
    return Text(
      i,
      textAlign: TextAlign.center,
      style: const TextStyle(
          color: Colors.teal,
          fontFamily: 'Lobster',
          fontSize: 26,
          wordSpacing: 5),
    );
  }).toList();
}
