import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:link_verse/views/auth_email.dart';

class StartView extends StatefulWidget {
  const StartView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StartViewState();
  }
}

class _StartViewState extends State<StartView> {
  final images =
      List.generate(3, (index) => "assets/onboarding/img${index + 1}.png");

  void _start() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const AuthEmail()));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: DecoratedBox(
          decoration: const BoxDecoration(color: Color(0xFF0F2E39)),
          child: Center(
            child: CarouselSlider(
              options: CarouselOptions(height: double.infinity, autoPlay: true),
              items: images
                  .map((e) => Image.asset(
                        e,
                        fit: BoxFit.fill,
                      ))
                  .toList(),
            ),
          ),
        )),
        Container(
          height: 46,
          decoration: const BoxDecoration(color: Color(0xFF326172)),
          alignment: Alignment.center,
          child: TextButton(
            onPressed: _start,
            style: TextButton.styleFrom(minimumSize: Size.infinite),
            child: const Text(
              'START NOW',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        )
      ],
    );
  }
}
