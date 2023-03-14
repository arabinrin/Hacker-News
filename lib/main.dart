import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:hacker_news/controller/news+provider.dart';
import 'package:hacker_news/screens/onboarding.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hacker_news/screens/home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider(create: (_) => NewsStroryProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 811),
      builder: (BuildContext context, Widget? child) => MaterialApp(
        title: 'Hacker News',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: const AnimatedSplash(),
      ),
    );
  }
}

class AnimatedSplash extends StatelessWidget {
  const AnimatedSplash({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splashIconSize: MediaQuery.of(context).size.height,
      splash: Onboarding(),
      nextScreen: const NewsHome(),
      splashTransition: SplashTransition.fadeTransition,
      duration: 2000,
    );
  }
}
