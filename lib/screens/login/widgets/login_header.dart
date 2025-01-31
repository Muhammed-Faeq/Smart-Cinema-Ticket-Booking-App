import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Lottie.asset(
          "assets/logos/person.json",
          height: 150,
        ),
        Text(
          "Welcome back,",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          "Discover Limitless Choices and Unmatched Convenience.",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
