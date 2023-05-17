import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'app.dart'; 
import 'package:hive_flutter/hive_flutter.dart'; 

late Box box; 

void main() async {
  // await Hive.initFlutter(); 
  // Hive.registerAdapter(SongAdapter()); 
  // box = await Hive.openBox("allSongs"); 

  WidgetsFlutterBinding.ensureInitialized(); 
  await EasyLocalization.ensureInitialized(); 
  runApp(EasyLocalization(
    supportedLocales: const [
      Locale("en", "US"), 
    ], 
    path: "assets/translations", 
    fallbackLocale: const Locale('en', 'US'),
    child: const MyApp(), 
    )
  );
}

