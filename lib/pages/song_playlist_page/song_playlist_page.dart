
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:my_music_player/domain/domain.dart';
import 'package:my_music_player/providers/providers.dart';
import 'package:my_music_player/theme/theme.dart';
import 'package:my_music_player/widgets/widgets.dart';
import 'package:provider/provider.dart';

class SongPlaylistPage extends StatefulWidget {
  const SongPlaylistPage({
    super.key, 
  }); 

  @override
  State<SongPlaylistPage> createState() => _SongPlaylistPageState();
}

class _SongPlaylistPageState extends State<SongPlaylistPage> {

  SongPlaylistPageArguments songPlaylistPageArguments = Get.arguments; 
  late SongPlaylist songPlaylist = songPlaylistPageArguments.songPlaylist; 

  @override
  Widget build(BuildContext context) {
    final AudioPlayerProvider audioPlayerProvider = context.watch<AudioPlayerProvider>();
    final TextStyle? headerTextStyle = Theme.of(context)
        .textTheme
        .headlineSmall;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: backgroundDecoration, 
        padding: const EdgeInsets.all(10), 
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: AlbumArt(
                imageData: null, 
                height: 300,
              ), 
            ), 
            const SizedBox(height: 20,),
            _Details(headerTextStyle: headerTextStyle), 
            SizedBox(
              child: Row(
                children: [
                  _PlaylistButton(
                    icon: const Icon(Icons.play_arrow), 
                    label: const Text("Play all"), 
                    onPressed: () {
                      audioPlayerProvider.startAndGoToAudioPlayer(context, songPlaylist.songs, 0); 
                    },
                  ),
                  _PlaylistButton(
                    icon: const Icon(Icons.shuffle), 
                    label: const Text("Shuffle"), 
                    onPressed: () {

                    },
                  ),
                ],
              ),
            )
          ],
        ), 
      ), 
    );
  }
}

class _PlaylistButton extends StatelessWidget {
  const _PlaylistButton({
    Key? key, 
    required this.icon, 
    required this.label, 
    required this.onPressed,
  }) : super(key: key);

  final Widget icon; 
  final Widget label; 
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed, 
      icon: icon, 
      label: label
    );
  }
}

class _Details extends StatelessWidget {
  const _Details({
    Key? key,
    required this.headerTextStyle,
  }) : super(key: key);

  final TextStyle? headerTextStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          AutomaticMarqueeText(
            marquee: Marquee(
              text: "Playlist Name", 
              style: headerTextStyle,
            ), 
            context: context, 
            text: "Playlist Name", 
            maxWidth: MediaQuery.of(context).size.width, 
            style: headerTextStyle,
          ), 
          Text(
            "100 songs - 1:12:4 hours of playtime", 
            style: Theme.of(context)
                .textTheme
                .labelMedium,
          ), 
        ],
      ),
    );
  }
}

