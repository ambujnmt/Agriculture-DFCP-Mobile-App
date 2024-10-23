import 'package:dfcp/utils/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class StudentTabView extends StatefulWidget {
  const StudentTabView({super.key});

  @override
  State<StudentTabView> createState() => _StudentTabViewState();
}

class _StudentTabViewState extends State<StudentTabView> {
  final customText = CustomText();
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Student Screen')),
    );
  }
}
