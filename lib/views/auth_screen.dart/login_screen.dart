import 'package:dfcp/custom_widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Login screen');
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/login_background.png'))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomButton(
              buttonText: 'Login',
              onpress: () {
                print('This is login butotn');
              },
            ),
            const SizedBox(height: 20),
            CustomButton(
              buttonText: 'Create Account',
            ),
          ],
        ),
      ),
    );
  }
}
