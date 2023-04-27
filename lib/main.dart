import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'app.dart'; 
import 'examples/examples.dart'; 

void main() async {
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

