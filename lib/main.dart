import 'package:curve_navbar/firebase_options.dart';
import 'package:curve_navbar/mainScreen_Navbar/main_screen.dart';
import 'package:curve_navbar/routes/routes.dart';
import 'package:curve_navbar/screens/onboarding/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
    SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthenticationWrapper(),
      getPages: Routes.routes,
    );
  }
}

class AuthenticationWrapper extends StatefulWidget {
  const AuthenticationWrapper({super.key});

  @override
  State<AuthenticationWrapper> createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  late final FirebaseAuth _auth;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;

    /// Listen to authentication changes and navigate accordingly
    _auth.authStateChanges().listen(
      (User? user) {
        if (user != null) {
          /// User is logged in
          Get.offAll(() => const MainScreen());
        } else {
          /// User is logged out
          Get.offAll(() => const SplashScreen());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    /// Display a splash or loading screen while waiting for auth state
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
