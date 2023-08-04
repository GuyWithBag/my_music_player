import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_music_player/providers/providers.dart';
import 'package:my_music_player/widgets/widgets.dart';
import 'package:provider/provider.dart';

class QueryAudioPage extends StatelessWidget {
  const QueryAudioPage({
    super.key
  }); 

  final double iconSize = 250; 

  @override
  Widget build(BuildContext context) { 
    const ButtonStyle myButton = ButtonStyle(
      backgroundColor: MaterialStatePropertyAll(Colors.grey), 
    ); 
    
    return ChangeNotifierProvider(
      create: (context) => QueryAudioProvider(),
      child: Builder(
        builder: (context) {
          QueryAudioProvider audioQueryProvider = context.watch<QueryAudioProvider>(); 
          AllSongsProvider allSongsProvider = context.watch<AllSongsProvider>(); 
          return Scaffold(
            appBar: AppBar(
              title: const Text("Scan Phone For Media"), 
            ), 
            body: BackgroundContainer(
              padding: const EdgeInsets.all(15), 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,  
                children: [
                  SizedBox( 
                    height: iconSize, 
                    width: iconSize,
                    child: FittedBox(
                      fit: BoxFit.cover, 
                      child: audioQueryProvider.searchingForSongs == true ? const CircularProgressIndicator.adaptive() : const Icon(Icons.circle_outlined)
                    ), 
                  ), 
                  Text("${audioQueryProvider.items.length} songs added to music player"), 
                  Column(
                    children: [
                      _ScanPhoneTile(
                        title: Row(
                          children: [
                            const Text("Ignore files under "), 
                            Container(
                              width: 60,
                              height: 60,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(), 
                                ),
                              )
                            ), 
                            const Text("second"), 
                          ],
                        ), 
                        value: true, 
                        onChanged: (value) {
    
                        },
                      ), 
                      _ScanPhoneTile(
                        title: Row(
                          children: [
                            const Text("Ignore files under "), 
                            Container(
                              width: 60, 
                              height: 50, 
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(), 
                                ),
                              )
                            ), 
                            const Text("kb"), 
                          ],
                        ), 
                        value: true, 
                        onChanged: (value) {
    
                        },
                      ), 
                      _ScanPhoneTile(
                        title: Row(
                          children: [
                            const Text("Ignore folders in "), 
                            TextButton(
                              onPressed: () {
                                
                              },
                              child: const Text("Blacklist"), 
                            ), 
                          ],
                        ), 
                        value: true, 
                        onChanged: (value) {
    
                        },
                      ), 
                    ], 
                  ), 
                  SizedBox(
                    height: 50,
                    child: audioQueryProvider.items.isEmpty ? 
                      Row(
                        children: [
                          Expanded( 
                            child: ElevatedButton(
                              onPressed: () { 
                                audioQueryProvider.querySongs(); 
                              }, 
                              style: myButton,
                              child: const Text("START"), 
                            ),
                          ),
                        ],
                      )
                    :
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                        crossAxisAlignment: CrossAxisAlignment.stretch, 
                        children: [ 
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                allSongsProvider.setItems(audioQueryProvider.items); 
                                Get.back(result: "result"); 
                              }, 
                              style: myButton, 
                              child: const Text("DONE"), 
                            ),
                          ), 
                          const SizedBox(width: 10), 
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Get.back(); 
                              }, 
                              style: myButton, 
                              child: const Text("RECENTLY ADDED"), 
                            ),
                          ),
                        ],
                      ),
                  )
                ],
              )
            ),
          );
        }
      ),
    );
  }
}

class _ScanPhoneTile extends StatelessWidget {
  const _ScanPhoneTile({
    super.key, 
    required this.title, 
    required this.value, 
    this.onChanged, 
  }); 

  final Widget title; 
  final bool value; 
  final void Function(bool?)? onChanged; 

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile.adaptive(
      controlAffinity: ListTileControlAffinity.leading, 
      title: title, 
      value: value, 
      onChanged: onChanged, 
    );
  }
}
