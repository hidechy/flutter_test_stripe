import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'screens/check_out_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';
import 'state/application_login_state.dart';
import 'utils/custom_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final response = await rootBundle.loadString('assets/config/stripe.json');
  final data = await json.decode(response);
  // ignore: avoid_dynamic_calls
  Stripe.publishableKey = data['publishableKey'];

  runApp(
    ChangeNotifierProvider(
      create: (context) => ApplicationState(),
      builder: (context, _) {
        return Consumer<ApplicationState>(builder: (context, applicationState, _) {
          Widget child;
          switch (applicationState.loginState) {
            case ApplicationLoginState.loggedIn:
              child = const MyApp();
              break;

            case ApplicationLoginState.loggedOut:
            // ignore: no_default_cases
            default:
              child = const LoginScreen();
              break;
          }

          return MaterialApp(
            theme: CustomTheme.getTheme(),
            home: child,
          );
        });
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(title: const Text('Shoppers')),
        backgroundColor: Colors.white,
        bottomNavigationBar: const DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            ),
            boxShadow: CustomTheme.cardShadow,
          ),
          child: TabBar(
            padding: EdgeInsets.symmetric(vertical: 10),
            indicatorColor: Colors.transparent,
            tabs: [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.person)),
              Tab(icon: Icon(Icons.shopping_cart)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [HomeScreen(), ProfileScreen(), CheckOutScreen()],
        ),
      ),
    );
  }
}
