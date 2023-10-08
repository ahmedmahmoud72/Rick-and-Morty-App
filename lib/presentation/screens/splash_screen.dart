import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/presentation/constants/strings.dart';

class SplashScreen extends StatefulWidget {
  final bool? login;

  const SplashScreen({
    this.login,
    Key? key,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, AppRoutes.charactersScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        'assets/images/splash_screen.jpg',
        height: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }
}
