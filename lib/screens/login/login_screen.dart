import 'package:curve_navbar/screens/login/widgets/login_form.dart';
import 'package:curve_navbar/widgets/login_signup/form_divider.dart';
import 'package:curve_navbar/widgets/login_signup/social_buttons.dart';
import 'package:flutter/material.dart';

import 'widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        padding:
            EdgeInsets.only(top: 56.0, left: 24.0, bottom: 24.0, right: 24.0),
        child: Column(
          children: [
            /// Logo, Title & sub-Title
            LoginHeader(),

            ///Form
            LoginForm(),

            ///Divider
            FormDivider(dividerText: "or sign in with"),
            SizedBox(height: 32.0),

            ///Footer
            SocialButton()
          ],
        ),
      ),
    );
  }
}
