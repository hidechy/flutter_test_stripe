import 'package:flutter/material.dart';
import 'package:test_stripe_shopper/utils/custom_theme.dart';

class CustomTextInput extends StatelessWidget {
  const CustomTextInput(
      {super.key,
      required this.label,
      required this.placeHolder,
      required this.icon,
      required this.textEditingController,
      this.password = false});

  final String label;
  final String placeHolder;
  final IconData icon;
  final TextEditingController textEditingController;
  final bool password;

  ///
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 8),
            child: Text(
              label,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          SizedBox(
            height: 56,
            child: TextField(
              controller: textEditingController,
              obscureText: password,
              enableSuggestions: !password,
              autocorrect: !password,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 22, end: 20),
                  child: Icon(
                    icon,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35),
                ),
                filled: true,
                hintStyle: const TextStyle(color: CustomTheme.grey),
                hintText: placeHolder,
                fillColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
