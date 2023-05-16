import 'package:flutter/material.dart'; 
import 'package:get/get.dart'; 
import '../domain/domain.dart'; 
import '../pages/pages.dart'; 

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final NavBarController controller = Get.put(NavBarController()); 

  BottomNavigationBarItem _bottombarItem(IconData icon, String label) {
    return BottomNavigationBarItem(icon: Icon(icon), label: label); 
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavBarController>(
      builder: (context) {
        return Scaffold(
          body: IndexedStack(
            index: controller.tabIndex, 
            children: const [
              SongListPage(), 
              AudioPlayerPage(), 
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.white, 
            unselectedItemColor: Colors.purple,
            currentIndex: controller.tabIndex, 
            onTap: controller.changeTabIndex,
            items: [
              _bottombarItem(Icons.music_note, "Songs"), 
              _bottombarItem(Icons.audio_file, "Audio Player")
            ],
          ),
        ); 
      }
    );
  }
}