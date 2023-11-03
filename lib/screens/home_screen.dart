import 'package:flutter/material.dart';

import '../components/grid_card.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final data = ['1', '2'];

  ///
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 30,
        crossAxisSpacing: 30,
      ),
      itemBuilder: (context, index) {
        return GridCard(
          index: index,
          press: onCardPress,
        );
      },
      itemCount: data.length,
    );
  }

  ///
  void onCardPress() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
