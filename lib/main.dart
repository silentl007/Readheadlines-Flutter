import 'dart:async';
import 'package:ReadHeadlines/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          '/home': (context) => HomeScreen(),
        },
        theme: ThemeData(
          appBarTheme: AppBarTheme(color: Colors.black),
        ),
        home: Splashscreen());
  }
}

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  void startTimer() {
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('/home');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/Pg1/splash.png'), fit: BoxFit.cover),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/Pg1/RHlogo.png',
                width: MediaQuery.of(context).size.width * .4),
            SizedBox(
              height: 20,
            ),
            // LoadingBouncingGrid.circle()
            CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue[200]),
              backgroundColor: Colors.grey[300],
              strokeWidth: 2.0,
            )
          ],
        ),
      ),
    );
  }
}
