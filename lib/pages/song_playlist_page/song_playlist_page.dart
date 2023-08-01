
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:my_music_player/domain/domain.dart';
import 'package:my_music_player/providers/providers.dart';
import 'package:my_music_player/theme/theme.dart';
import 'package:my_music_player/widgets/widgets.dart';
export 'widgets/widgets.dart'; 
import 'package:provider/provider.dart';

import 'widgets/widgets.dart';

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
    const double actionsButtonSize = 30; 
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkwellIcon(
            onTap: () {

            },
            fit: BoxFit.contain, 
            height: actionsButtonSize,
            width: actionsButtonSize, 
            icon: const Icon(Icons.search), 
          ), 
          IconButton(
            onPressed: () {
              Get.toNamed(
                "/SelectSongs", 
                arguments: SelectSongsPageArguments(songPlaylist)
              ); 
            },
            icon: const Icon(Icons.add), 
          ), 
          const SizedBox(width: 10), 
          InkwellIcon(
            onTap: () {

            },
            fit: BoxFit.contain,
            height: actionsButtonSize,
            width: actionsButtonSize,
            icon: const Icon(Icons.more_vert), 
          ), 
        ],
      ),
      body: Container(
        decoration: backgroundDecoration, 
        padding: const EdgeInsets.all(10), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: () {
                  songPlaylist.pickImageAndSetAsThumbnail(); 
                },
                child: const AlbumArt(
                  imageData: null, 
                  height: 300,
                ),
              ), 
            ), 
            const SizedBox(height: 20),
            _Details(
              playlist: songPlaylist, 
            ), 
            const SizedBox(height: 20),
            _PlaylistPlayButtons(
              audioPlayerProvider: audioPlayerProvider, 
              songPlaylist: songPlaylist, 
            ),
            Flexible(
              child: SongPlaylistPageSongList(
                songs: songPlaylist.songs, 
                onReorder: (int oldIndex, int newIndex) {
                  List<Song> songs = songPlaylist.songs; 
                  setState(() {
                    onReOrderUpdateList(
                      oldIndex, 
                      newIndex, 
                      songs.removeAt,
                      songs.insert
                    );
                  }); 
                }
              ),
            )
          ],
        ), 
      ), 
    );
  }
}

class _PlaylistPlayButtons extends StatelessWidget {
  const _PlaylistPlayButtons({
    Key? key,
    required this.audioPlayerProvider,
    required this.songPlaylist,
  }) : super(key: key);

  final AudioPlayerProvider audioPlayerProvider;
  final SongPlaylist songPlaylist;
  final double playlistButtonHeight = 50;
  final double playlistButtonWidth = 160;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          _PlaylistButton(
            icon: const Icon(Icons.play_arrow), 
            label: const Text("Play all"), 
            onPressed: () {
              audioPlayerProvider.startAndGoToAudioPlayer(context, songPlaylist.songs, 0); 
            }, 
            height: playlistButtonHeight,
            width: playlistButtonWidth, 
            borderRadius: BorderRadius.circular(10),
          ),
          const Spacer(), 
          _PlaylistButton(
            icon: const Icon(Icons.shuffle), 
            label: const Text("Shuffle"), 
            onPressed: () {

            },
            height: playlistButtonHeight,
            width: playlistButtonWidth,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
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
    required this.height, 
    required this.width, 
    required this.borderRadius,
  }) : super(key: key);

  final Widget icon; 
  final Widget label; 
  final Function()? onPressed;
  final double? height; 
  final double? width; 
  final BorderRadius borderRadius; 

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: SizedBox(
        height: height,
        width: width,
        child: ElevatedButton.icon(
          onPressed: onPressed, 
          icon: icon, 
          label: label
        ),
      ),
    );
  }
}

class _Details extends StatelessWidget {
  const _Details({
    Key? key, 
    required this.playlist,
  }) : super(key: key);

  final SongPlaylist playlist; 
  

  void promptEditPlaylistName(BuildContext context, SongPlaylist playlist) {
    TextEditingController textEditingController = TextEditingController(); 
    Widget dialog = _RenameDialog(
      playlist: playlist,
      textEditingController: textEditingController, 
    ); 
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return dialog; 
      }
    ); 
  }

  @override
  Widget build(BuildContext context) {
    final List<Song> songs = playlist.songs; 
    final TextStyle? headerTextStyle = Theme.of(context)
      .textTheme
      .headlineSmall;
    // ignore: unused_local_variable
    final SongPlaylistProvider songPlaylistProvider = context.watch<SongPlaylistProvider>(); 
    return SizedBox(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              promptEditPlaylistName(context, playlist); 
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutomaticMarqueeText(
                  marquee: Marquee(
                    text: playlist.name, 
                    style: headerTextStyle, 
                  ), 
                  context: context, 
                  text: playlist.name, 
                  maxWidth: MediaQuery.of(context).size.width, 
                  style: headerTextStyle,
                ), 
                const SizedBox(width: 10), 
                const Icon(Icons.edit), 
              ],
            ),
          ), 
          Text(
            "${songs.length} songs - 1:12:4 hours of playtime", 
            style: Theme.of(context)
                .textTheme
                .labelMedium,
          ), 
        ],
      ),
    );
  }
}

class _RenameDialog extends StatelessWidget {
  const _RenameDialog({
    Key? key, 
    required this.playlist, 
    required this.textEditingController, 
  }) : super(key: key);

  final SongPlaylist playlist; 
  final TextEditingController textEditingController; 

  @override
  Widget build(BuildContext context) {
    final SongPlaylistProvider songPlaylistProvider = context.watch<SongPlaylistProvider>(); 
    return AlertDialog(
      title: const Text("Rename Playlist"), 
      backgroundColor: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(6)
      ),
      content: _RenameDialogContent(
        textEditingController: textEditingController
      ), 
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context); 
          }, 
          child: const Text("Cancel")
        ), 
        ElevatedButton(
          onPressed: () {
            playlist.setName(textEditingController.text); 
            songPlaylistProvider.updateNotifier(); 
            Navigator.pop(context); 
          }, 
          child: const Text("Confirm")
        ), 
      ], 
    );
  }
}

class _RenameDialogContent extends StatelessWidget {
  const _RenameDialogContent({
    Key? key, 
    required this.textEditingController
  }) : super(key: key); 

  final TextEditingController textEditingController; 

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: textEditingController,
        decoration: const InputDecoration(
        border: UnderlineInputBorder(), 
        labelText: "Playlist Name: "
      ),
    );
  }
}