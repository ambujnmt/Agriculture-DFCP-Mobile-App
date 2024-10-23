import 'package:dfcp/utils/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class UserTabView extends StatefulWidget {
  const UserTabView({super.key});

  @override
  State<UserTabView> createState() => _UserTabViewState();
}

class _UserTabViewState extends State<UserTabView> {
  final customText = CustomText();
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('User Screen')),
    );
  }
}
