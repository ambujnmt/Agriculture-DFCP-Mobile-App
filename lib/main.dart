import 'package:dfcp/views/intro_screen.dart';
import 'package:flutter/material.dart';
// import 'package:media_kit/media_kit.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // MediaKit.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const IntroScreen(),
    );
  }
}


