import 'package:dfcp/utils/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class FarmerTabView extends StatefulWidget {
  const FarmerTabView({super.key});

  @override
  State<FarmerTabView> createState() => _FarmerTabViewState();
}

class _FarmerTabViewState extends State<FarmerTabView> {
  final customText = CustomText();
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Farmer Screen')),
    );
  }
}
