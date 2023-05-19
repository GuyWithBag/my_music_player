import 'package:flutter/material.dart';
import 'package:my_music_player/pages/song_list_page/widgets/song_list.dart';
import '../../../data/database.dart';
import '../../../domain/audio_player.dart'; 

class AllSongsPage extends StatelessWidget {
  const AllSongsPage({Key? key, required this.songs}) : super(key: key);

  final List<Song> songs; 

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Column(
        children: [
          SongListSubHeader(songs: songs), 
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(top: 10), 
              child: SongList(songs: songs)
            ),
          )
        ],
      )
    ); 
  }
}

class SongListSubHeader extends StatelessWidget {
  const SongListSubHeader({
    Key? key,
    required this.songs,
  }) : super(key: key);

  final List<Song> songs; 

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Row(
          children: [
            Expanded(
              flex: 12,
              child: Text("${songs.length} songs")
            ), 
            const Expanded(
              flex: 1,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SmallTabIcon(
                      icon: Icon(
                        Icons.sort, 
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 25), 
                    SmallTabIcon(
                      icon: Icon(
                        Icons.list, 
                        color: Colors.white,
                      ),
                    ), 
                  ],
                ),
              ),
            ), 
          ],
        ),
      ),
    );
  }
}

class SmallTabIcon extends StatelessWidget {
  const SmallTabIcon({
    Key? key, 
    required this.icon, 
  }) : super(key: key);

  final Icon icon; 

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple, 
      height: 20,
      child: InkWell(
        onTap: () {},
        child: icon
      ),
    );
  }
}
