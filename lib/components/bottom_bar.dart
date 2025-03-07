import 'package:final_project/style/color_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lucide_icons/lucide_icons.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _animationController.forward().then((_) => _animationController.reverse());
    if (index == 0) {
      Get.toNamed('/home');
    } else {
      Get.toNamed('/profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.mainColor,
      unselectedItemColor: Colors.grey,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: [
        BottomNavigationBarItem(
          icon: ScaleTransition(
            scale: Tween(begin: 1.0, end: 1.2).animate(CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeInOut,
            )),
            child: Icon(LucideIcons.home),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: ScaleTransition(
            scale: Tween(begin: 1.0, end: 1.2).animate(CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeInOut,
            )),
            child: Icon(LucideIcons.user),
          ),
          label: 'Profile',
        ),
      ],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
