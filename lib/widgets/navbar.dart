import 'package:file_picker/file_picker.dart'; 
import 'package:flutter/material.dart'; 
import 'package:get/get.dart';

import 'package:provider/provider.dart'; 
import '../controllers/controllers.dart';
import '../domain/domain.dart'; 
import '../pages/pages.dart'; 
import '../providers/providers.dart'; 

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

// enum _popupMenuValues {
//   settings, 
// }

class _NavBarState extends State<NavBar> {
  final NavBarController controller = Get.put(NavBarController()); 

  @override
  Widget build(BuildContext context) {
    final AllSongsProvider allSongsProvider = context.watch<AllSongsProvider>(); 
    return GetBuilder<NavBarController>(
      builder: (NavBarController navBarController) {
        return Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  elevation: 0,
                  title: const Text("Music Player"), 
                  floating: true,
                  expandedHeight: 80,
                  snap: true,
                  forceElevated: innerBoxIsScrolled,
                  actions: <Widget>[
                    IconButton(
                      onPressed: () {
                        Get.toNamed('/SearchResults'); 
                      }, 
                      icon: const Icon(Icons.search),  
                    ), 
                    IconButton(
                      onPressed: () {
                        Get.toNamed('/Settings'); 
                      }, 
                      icon: const Icon(Icons.settings),  
                    ), 
                    PopupMenuButton(
                      icon: const Icon(Icons.more_vert), 
                      itemBuilder: (context) => const [
                        PopupMenuItem(
                          value: 1, 
                          child: Text("Scan Songs"),
                        )
                      ],
                      onSelected: (value) {
                        switch (value) {
                          case 1: 
                            Get.toNamed("/QueryAudioPage"); 
                        }
                      },
                    ), 
                    const SizedBox(width: 10)
                  ],

                )
              ]; 
            },
            body: IndexedStack(
              index: controller.tabIndex, 
              children: const [
                SongListPage(), 
                MoreFeaturesPage(),    
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.tabIndex, 
            onTap: controller.changeTabIndex,
            items: const [
              BottomNavigationBarItem(
                label: "Songs", 
                icon: Icon(Icons.music_note), 
              ), 
              BottomNavigationBarItem(
                label: "More", 
                icon: Icon(Icons.more), 
              ), 
            ],
          ),
        ); 
      }
    );
  }
}
