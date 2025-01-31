import 'package:curve_navbar/controller/bottom_navigation_bar_controller.dart';
import 'package:curve_navbar/screens/main/favorite_screen.dart';
import 'package:curve_navbar/screens/main/home_screen.dart';
import 'package:curve_navbar/screens/main/profile_screen.dart';
import 'package:curve_navbar/screens/main/search_screen.dart';
import 'package:curve_navbar/screens/main/ticket_fill_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
  });

  @override
  State<MainScreen> createState() => _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<MainScreen> {
  final controller = Get.put(BTNController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BTNController>(
      builder: (BTNController controller) {
        return Scaffold(
          body: IndexedStack(
            index: controller.tabIndex,
            children: const [
              HomeScreen(),
              FavoriteScreen(),
              SearchScreen(),
              TicketFillScreen(),
              ProfileScreen(),
            ],
          ),
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: const Color(0xFF090E17),
            color: const Color(0xFF1E2433),
            animationDuration: const Duration(milliseconds: 200),
            onTap: controller.changeTabIndex,
            index: controller.tabIndex,
            items: const [
              Icon(Icons.home, color: Colors.white, size: 30),
              Icon(Icons.favorite, color: Colors.white, size: 30),
              Icon(Icons.search, color: Colors.white, size: 30),
              Icon(CupertinoIcons.ticket_fill, color: Colors.white, size: 30),
              Icon(Icons.person_rounded, color: Colors.white, size: 30),
            ],
          ),
        );
      },
    );
  }
}
