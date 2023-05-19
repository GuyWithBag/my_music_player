import 'package:flutter/material.dart'; 
import 'package:get/get.dart'; 
import '../domain/domain.dart'; 
import '../pages/pages.dart'; 

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

  enum _popupMenuValues {
    settings, 
  }

class _NavBarState extends State<NavBar> {
  final NavBarController controller = Get.put(NavBarController()); 

  BottomNavigationBarItem _bottombarItem(IconData icon, String label) {
    return BottomNavigationBarItem(icon: Icon(icon), label: label); 
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavBarController>(
      builder: (NavBarController navBarController) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: const Text("Music Player"), 
            actions: <Widget>[
              IconButton(
                onPressed: () {}, 
                icon: const Icon(Icons.search),  
              ), 
              PopupMenuButton(
                icon: const Icon(Icons.more_vert), 
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    child: Text("Settings"), 
                    value: _popupMenuValues.settings,
                  )
                ],
                onSelected: (value) {
                  switch (value) {
                    case _popupMenuValues.settings: 
                      Get.toNamed('/Settings'); 
                  }
                },
              ), 
              const SizedBox(width: 10)
            ],
          ),
          body: IndexedStack(
            index: controller.tabIndex, 
            children: const [
              SongListPage(), 
              AudioPlayerPage(), 
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.purple, 
            unselectedItemColor: Colors.grey,
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
