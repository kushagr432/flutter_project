import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'homePage.dart';
class startScreen extends StatefulWidget {
  const startScreen({super.key});

  @override
  State<startScreen> createState() => _startScreenState();
}

class _startScreenState extends State<startScreen> with TickerProviderStateMixin{
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Center(
            child: Lottie.asset("assets/lottie/animation_llfegark.json",
                height: 300, width: 300,
                controller: _controller,
                onLoaded: (composition)
                {
                  _controller
                    ..duration = composition.duration
                    ..forward().whenComplete(() =>
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => homePage()),),
                    );
                }
            ),
          ),
        ) );
  }
}