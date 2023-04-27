import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart'; 
import 'package:get/get.dart'; 
import 'pages/pages.dart'; 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white, 
          displayColor: Colors.white, 
        )
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const SongsPage(), 
      getPages: [
        GetPage(name: '/', page: () => const HomePage())
      ],
    );
  }
}
