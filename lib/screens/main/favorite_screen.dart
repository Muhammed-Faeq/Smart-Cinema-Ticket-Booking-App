import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF090E17),
      body: Center(
        child: Text(
          "F A V O R I T E",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
