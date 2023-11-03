import 'package:flutter/material.dart';
import 'package:test_stripe_shopper/components/custom_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              'aaaaa',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          CustomButton(
            text: 'Sign Out',
            press: () {},
          ),
        ],
      ),
    );
  }
}
