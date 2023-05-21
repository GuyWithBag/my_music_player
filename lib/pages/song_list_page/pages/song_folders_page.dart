import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:my_music_player/pages/song_list_page/widgets/widgets.dart';
import '../../../theme/theme.dart';
import '../../../widgets/widgets.dart';


class SongFoldersPage extends StatelessWidget {
  const SongFoldersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundDecoration, 
      child: Padding(
        padding: const EdgeInsets.all(20), 
        child: Container(
          color: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10
            ),
            child: Column(
              children: [
                SubHeader(
                  header: Text("Add Folder"), 
                  padding: const EdgeInsets.only(top: 15), 
                  actions: [
                    SubHeaderAction(
                      onTap: () {},
                      icon: const Icon(Icons.add)
                    )
                  ], 
                ), 
                // ignore: prefer_const_constructors
                SubHeader(
                  header: Text('"MusicPlayerCloud/Path/Path"'), 
                  padding: EdgeInsets.symmetric(vertical: 15),
                  actions: <SubHeaderAction>[]
                ), 
                // ignore: prefer_const_constructors
                FoldersList(

                ), 
                // ignore: prefer_const_constructors
                SongsList(

                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}

class SongsList extends StatelessWidget {
  const SongsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FileTile(
          onTap: () {
            
          }, 
          fileName: "Gay",
        )
      ],
    );
  }
}

class FoldersList extends StatelessWidget {
  const FoldersList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FolderTile(
          onTap: () {}, 
          folderName: "My Song",
        ),
      ],
    );
  }
}

class FolderTile extends StatelessWidget {
  const FolderTile({
    Key? key, 
    required this.onTap, 
    required this.folderName, 
  }) : super(key: key);

  final Function()? onTap; 
  final String folderName; 

  @override
  Widget build(BuildContext context) {
    return SongFoldersPageTile(
      onTap: onTap, 
      folderName: folderName, 
      icon: const Icon(Icons.folder), 
      listIcon: const CircleAvatar(
        radius: 3, 
        backgroundColor: Colors.white,
      ),
    );
  }
}

class FileTile extends StatelessWidget {
  const FileTile({
    Key? key, 
    required this.onTap, 
    required this.fileName, 
  }) : super(key: key);

  final Function()? onTap; 
  final String fileName; 

  @override
  Widget build(BuildContext context) {
    return SongFoldersPageTile(
      onTap: onTap, 
      folderName: fileName, 
      icon: const Icon(Icons.audio_file), 
      listIcon: const Icon(Icons.remove),
    );
  }
}

class SongFoldersPageTile extends StatelessWidget {
  const SongFoldersPageTile({
    super.key,
    required this.onTap,
    required this.folderName, 
    required this.icon, 
    required this.listIcon, 
  }); 

  final Function()? onTap;
  final String folderName; 
  final Icon icon; 
  final Widget listIcon; 

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).primaryColorLight
            )
          ), 
        ),
        height: 70,
        child: Row(
          children: [
            SizedBox(
              child: Row(
                children: [
                  SizedBox(
                    width: 30,
                    child: listIcon
                  ), 
                  const SizedBox(width: 20,), 
                  SizedBox(
                    height: 32,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: icon
                    )
                  ),
                ],
              ),
            ), 
            const SizedBox(width: 30,), 
            Text(folderName)
          ],
        )
      ),
    );
  }
}

