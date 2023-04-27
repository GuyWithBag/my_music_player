import 'package:file_picker/file_picker.dart'; 
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart'; 
import 'package:get/get.dart'; 
import '../pages/pages.dart'; 

class FilePickerExample extends StatelessWidget {
  const FilePickerExample({super.key});

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
      home: const FilePickerPage(), 
      getPages: [
        GetPage(name: '/', page: () => const HomePage())
      ],
    );
  }
}

class FilePickerPage extends StatelessWidget {
  const FilePickerPage({super.key});

  void _pickFile() async {

    String? result = await FilePicker.platform.getDirectoryPath(); 
    print(result); 

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              _pickFile(); 
            }, 
            child: const Text("Open File"), 
          ),
      ),
    );
  }
}

