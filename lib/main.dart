import 'package:dfcp/views/intro_screen.dart';
import 'package:dfcp/views/new_intro.dart';
import 'package:flutter/material.dart';
// import 'package:media_kit/media_kit.dart';

import 'package:flutter/services.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // MediaKit.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  // runApp(const MyApp());
  // Lock the orientation to portrait mode.
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DFCP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const NewIntroScreen(),
    );
  }
}
