import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart'; 
import 'package:get/get.dart';
import 'package:my_music_player/widgets/navbar.dart'; 
import 'pages/pages.dart'; 
import 'pages/search_results_page/pages/pages.dart';
import 'pages/settings_page/pages/pages.dart';
import 'theme/theme.dart'; 
import 'package:provider/provider.dart'; 
import 'providers/providers.dart'; 

// ThemeManager _themeManager = ThemeManager(); 

// ToDO: Implement the things for the settings page
// ToDo: Style the select songs page better 
// ToDo: Add a function to add to playlist 
// ToDo: Style songs queue page
// ToDo: Optimize widgets where it shouldn't have to rebuild the whole widget just for one widget
// ToDo: Fix the scroll controls for the song list page and the playlist page
// ToDo: Implement a proper function for the more button in audio player page 
// ToDo: Implement functions for more buttons in: SongQueuePage, SongPlaylistPage, SongListPage, AudioPlayerPage
// ToDo: Implement automatic finding of music page

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key
  }) : super(key: key);

  // This widget is the root of your application. 
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AllSongsProvider>(create: (_) => AllSongsProvider()),
        ChangeNotifierProvider<AudioPlayerProvider>(create: (_) => AudioPlayerProvider()),
        ChangeNotifierProvider<SongQueueProvider>(create: (_) => SongQueueProvider()),
        ChangeNotifierProvider<SongPlaylistProvider>(create: (_) => SongPlaylistProvider()),
        ChangeNotifierProvider<SongFavoritesProvider>(create: (_) => SongFavoritesProvider()), 
      ], 
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        themeMode: ThemeMode.light,
        theme: defaultTheme, 
        darkTheme: darkTheme,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        initialRoute: "/",
        getPages: [
          GetPage(name: "/", page: () => const NavBar()), 
          GetPage(name: "/SelectSongs", page: () => const SelectSongsPage()), 
          GetPage(name: "/AudioPlayer", page: () => const AudioPlayerPage()), 
          GetPage(name: "/SearchResults", page: () => const SearchResultsPage()), 
          GetPage(name: "/SearchResults/SeeMore", page: () => const SearchResultsSeeMorePage()), 
          GetPage(name: "/SongsList", page: () => const SongListPage()), 
          GetPage(name: "/SongsList/SongPlaylist", page: () => const SongPlaylistPage()), 
          GetPage(name: "/Settings", page: () => const SettingsPage()), 
          GetPage(name: "/Settings/Display", page: () => const DisplaySettingsPage()), 
          GetPage(name: "/Settings/Audio", page: () => const AudioSettingsPage()), 
        ], 
      ),
    );
  }
}

