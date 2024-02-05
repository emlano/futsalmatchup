import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/inter_text.dart';
import 'package:frontend/models/filled_button.dart';
import 'package:frontend/models/header_app_bar.dart';

class LoginScreen extends StatefulWidget {
  final String title;
  const LoginScreen({super.key, required this.title});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TitleAppBar(),
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
              enlargeFactor: 0.5),
          items: [0, 1, 2].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: const BoxDecoration(color: Colors.transparent),
                    child: FittedBox(
                      child: Column(
                        children: [
                          CarouselData.images[i],
                          const SizedBox(height: 10),
                          CarouselData.texts[i]
                        ],
                      ),
                    ));
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 100),
        Column(children: [
          const InterText(
              text: "Have an account?",
              size: 14,
              color: Colors.black54,
              weight: FontWeight.w100
          ),
          FilledIconButton(
              text: "Log in",
              icon: Icons.account_circle,
              onPressed: () { Navigator.pushNamed(context, 'login-page'); }),
          const SizedBox(height: 30),
          const InterText(
              text: "New user?",
              size: 14,
              color: Colors.black54,
              weight: FontWeight.w100
          ),
          FilledIconButton(
              text: "Sign in",
              icon: Icons.group_add,
              onPressed: () { Navigator.pushNamed(context, 'signin-page'); }
          ),
        ])
      ]),
    );
  }
}

class CarouselData {
  static final List<Image> images = [
    'assets/images/img1.png',
    'assets/images/img2.png',
    'assets/images/img3.png'
  ].map((i) {
    return Image.asset(
      i,
      width: 200,
      height: 200,
      isAntiAlias: true,
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
