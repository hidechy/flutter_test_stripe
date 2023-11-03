import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test_stripe_shopper/components/custom_button.dart';
import 'package:test_stripe_shopper/components/custom_text_input.dart';
import 'package:test_stripe_shopper/utils/custom_theme.dart';

import '../utils/login_data.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ///
  _LoginScreenState() {
    data = LoginData.signIn;
  }

  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController = TextEditingController();

  Map<String, String> data = {};

  ///
  void switchLogin() {
    setState(() {
      if (mapEquals(data, LoginData.signUp)) {
        data = LoginData.signIn;
      } else {
        data = LoginData.signUp;
      }
    });
  }

  ///
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40, bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      data['heading']!,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  Text(
                    data['subHeading']!,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            model(data, _emailEditingController, _passwordEditingController),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  child: TextButton(
                    onPressed: switchLogin,
                    child: Text(
                      data['footer']!,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///
  Widget model(
    Map<String, String> data,
    TextEditingController emailEditingController,
    TextEditingController passwordEditingController,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.only(right: 20, left: 20, top: 30, bottom: 56),
      decoration: CustomTheme.getCardDecoration(),
      child: Column(
        children: [
          CustomTextInput(
            label: 'email',
            placeHolder: 'email',
            icon: Icons.email,
            textEditingController: _emailEditingController,
          ),
          CustomTextInput(
            label: 'password',
            placeHolder: 'password',
            icon: Icons.lock_outline,
            textEditingController: _passwordEditingController,
            password: true,
          ),
          CustomButton(
            text: data['label']!,
            press: loginButtonPressed,
          )
        ],
      ),
    );
  }

  ///
  void loginButtonPressed() {}
}
