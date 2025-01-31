import 'package:curve_navbar/widgets/login_signup/text_field_decoration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  /// for password obscureText
  bool isPasswordSecure = true;
  bool isCoPasswordSecure = true;

  /// for text field controllers
  final firsNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneNOController = TextEditingController();

  /// Form key
  final _formKey = GlobalKey<FormState>();

  /// Signup function
  Future signUp() async {
    if (_formKey.currentState!.validate() && passwordConfirmed()) {
      try {
        // create user
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        /// add user details
        addUserDetails(
          firsNameController.text.trim(),
          lastNameController.text.trim(),
          int.parse(phoneNOController.text.trim()),
          emailController.text.trim(),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.greenAccent,
            content: Text(
              "Account created successfully!",
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  Future addUserDetails(
      String firstName, String lastName, int phoneNo, String email) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Save data to Firestore
      await FirebaseFirestore.instance.collection('user').doc(user.email).set(
        {
          'first name': firstName,
          'last name': lastName,
          'email': email,
          'phone number': phoneNo,
        },
      );
    }
  }

  /// Check if passwords match
  bool passwordConfirmed() {
    return passwordController.text.trim() ==
        confirmPasswordController.text.trim();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: firsNameController,
                  decoration: CustomInputDecoration.inputDecoration(
                    labelText: "First Name",
                    prefixIcon: const Icon(Iconsax.user),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "First name is required";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: TextFormField(
                  controller: lastNameController,
                  decoration: CustomInputDecoration.inputDecoration(
                    labelText: "Last Name",
                    prefixIcon: const Icon(Iconsax.user),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Last name is required";
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),

          /// Phone Number
          TextFormField(
            controller: phoneNOController,
            decoration: CustomInputDecoration.inputDecoration(
              labelText: "Phone Number",
              prefixIcon: const Icon(Iconsax.call),
            ),
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Phone number is required";
              }
              if (!RegExp(r'^\d+$').hasMatch(value)) {
                return "Phone number must be numeric";
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),

          /// Email
          TextFormField(
            controller: emailController,
            decoration: CustomInputDecoration.inputDecoration(
              labelText: "E-Mail",
              prefixIcon: const Icon(Iconsax.direct),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Email is required";
              }
              if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                  .hasMatch(value)) {
                return "Enter a valid email";
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),

          /// Password
          TextFormField(
            controller: passwordController,
            obscureText: isPasswordSecure,
            decoration: CustomInputDecoration.inputDecoration(
              labelText: "Password",
              prefixIcon: const Icon(Iconsax.password_check),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isPasswordSecure = !isPasswordSecure;
                  });
                },
                icon: isPasswordSecure
                    ? const Icon(Iconsax.eye_slash)
                    : const Icon(Iconsax.eye),
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Password is required";
              }
              if (value.length < 6) {
                return "Password must be at least 6 characters";
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),

          /// Confirm Password
          TextFormField(
            controller: confirmPasswordController,
            obscureText: isCoPasswordSecure,
            decoration: CustomInputDecoration.inputDecoration(
              labelText: "Confirm Password",
              prefixIcon: const Icon(Iconsax.password_check),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isCoPasswordSecure = !isCoPasswordSecure;
                  });
                },
                icon: isCoPasswordSecure
                    ? const Icon(Iconsax.eye_slash)
                    : const Icon(Iconsax.eye),
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Please confirm your password";
              }
              if (value != passwordController.text.trim()) {
                return "Passwords do not match";
              }
              return null;
            },
          ),

          const SizedBox(height: 32.0),

          /// Sign Up Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: signUp,
              child: const Text("Create account"),
            ),
          ),
        ],
      ),
    );
  }
}
