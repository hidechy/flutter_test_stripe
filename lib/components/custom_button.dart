import 'package:flutter/material.dart';
import 'package:test_stripe_shopper/components/loader.dart';
import 'package:test_stripe_shopper/utils/custom_theme.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.press, this.loading = false});

  final String text;
  final void Function() press;
  final bool loading;

  ///
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        color: CustomTheme.yellow,
        boxShadow: CustomTheme.buttonShadow,
      ),
      child: MaterialButton(
        onPressed: loading ? null : press,
        child: loading
            ? const Loader()
            : Text(
                text,
                style: Theme.of(context).textTheme.titleSmall,
              ),
      ),
    );
  }
}
