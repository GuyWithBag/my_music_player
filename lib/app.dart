import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart'; 
import 'package:get/get.dart';
import 'package:my_music_player/controllers/controllers.dart';
import 'package:my_music_player/widgets/navbar.dart'; 
import 'pages/pages.dart'; 
import 'pages/settings_page/pages/pages.dart';
import 'theme/theme.dart'; 
import 'package:provider/provider.dart'; 
import 'providers/providers.dart'; 

// ThemeManager _themeManager = ThemeManager(); 

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
        ChangeNotifierProvider<SongTileDraggableScrollSheetOptionsController>(create: (_) => SongTileDraggableScrollSheetOptionsController()), 
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
          GetPage(name: "/AudioPlayer", page: () => const AudioPlayerPage()), 
          GetPage(name: "/SearchResults", page: () => const SearchResultsPage()), 
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
