import 'package:curve_navbar/screens/sign%20up/Widgets/signup_form.dart';
import 'package:curve_navbar/widgets/login_signup/form_divider.dart';
import 'package:curve_navbar/widgets/login_signup/social_buttons.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Title
              Text(
                "Let's create your account",
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              const SizedBox(height: 15.0),

              ///Form
              const SignupForm(),
              const SizedBox(height: 32.0),

              ///Divider
              const FormDivider(dividerText: "or sign up with"),
              const SizedBox(height: 32.0),

              /// Social buttons
              const SocialButton(),
            ],
          ),
        ),
      ),
    );
  }
}
