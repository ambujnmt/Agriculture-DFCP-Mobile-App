import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:easy_stepper/easy_stepper.dart';

class ProgressStepperScreen extends StatefulWidget {
  const ProgressStepperScreen({super.key});

  @override
  State<ProgressStepperScreen> createState() => _ProgressStepperScreenState();
}

class _ProgressStepperScreenState extends State<ProgressStepperScreen> {
  int activeStep = 2;
  int activeStep2 = 2;
  @override
  Widget build(BuildContext context) {
    return EasyStepper(
      fitWidth: true,
      activeStepBorderColor: Colors.black,
      activeStepBackgroundColor: Colors.orange,
      activeStepIconColor: Colors.green,
      borderThickness: 4,
      direction: Axis.horizontal,
      activeStep: activeStep,
      activeStepTextColor: Colors.black87,
      finishedStepTextColor: Colors.black87,
      internalPadding: 0,
      showLoadingAnimation: false,
      stepRadius: 8,
      showStepBorder: false,
      steps: [
        EasyStep(
          customStep: CircleAvatar(
            radius: 8,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 7,
              backgroundColor: activeStep >= 0 ? Colors.orange : Colors.white,
            ),
          ),
          title: 'Waiting',
        ),
        EasyStep(
          customStep: CircleAvatar(
            radius: 8,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 7,
              backgroundColor: activeStep >= 1 ? Colors.orange : Colors.white,
            ),
          ),
          title: 'Order Received',
          topTitle: true,
        ),
        EasyStep(
          customStep: CircleAvatar(
            radius: 8,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 7,
              backgroundColor: activeStep >= 2 ? Colors.orange : Colors.white,
            ),
          ),
          title: 'Preparing',
        ),
        EasyStep(
          customStep: CircleAvatar(
            radius: 8,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 7,
              backgroundColor: activeStep >= 3 ? Colors.orange : Colors.white,
            ),
          ),
          title: 'On Way',
          topTitle: true,
        ),
        EasyStep(
          customStep: CircleAvatar(
            radius: 8,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 7,
              backgroundColor: activeStep >= 4 ? Colors.orange : Colors.white,
            ),
          ),
          title: 'Delivered',
        ),
      ],
      onStepReached: (index) => setState(() => activeStep = index),
    );
  }
}
