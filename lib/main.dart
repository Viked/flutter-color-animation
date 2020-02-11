import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final rng = Random();

  AnimationController _animationController;
  ColorTween _colorTween;
  Animation _colorTweenAnimation;

  @override
  void initState() {
    final color = _randomColor();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _colorTween = ColorTween(begin: color, end: color);
    _colorTweenAnimation = _colorTween.animate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
            child: AnimatedBuilder(
              animation: _colorTweenAnimation,
              builder: (context, child) => Container(
                color: _colorTweenAnimation.value,
                child: child,
              ),
              child: Center(child: Text('Hey there')),
            ),
            onTap: _setColor));
  }

  Color _randomColor() =>
      Color.fromARGB(255, rng.nextInt(255), rng.nextInt(255), rng.nextInt(255));

  void _setColor() {
    _colorTween.begin = _colorTweenAnimation.value;
    _colorTween.end = _randomColor();
    _animationController.reset();
    _animationController.forward();
  }
}
