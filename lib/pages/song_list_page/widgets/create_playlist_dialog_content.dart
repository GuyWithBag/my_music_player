import 'package:flutter/material.dart';

class CreatePlaylistDialogContent extends StatelessWidget {
  const CreatePlaylistDialogContent({
    super.key,
    required this.textEditingController,
  });

  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      color: Theme.of(context).primaryColor, 
      height: 100,
      child: Center(
        child: Row(
          children: [
            const _PlaylistArtDisplay(), 
            const SizedBox(width: 20,), 
            Expanded(
              child: TextFormField(
                controller: textEditingController,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(), 
                  labelText: "Playlist Name: "
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}

class _PlaylistArtDisplay extends StatelessWidget {
  const _PlaylistArtDisplay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40, 
      width: 40,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          color: Colors.grey,
          child: const Icon(Icons.music_note)
        ),
      ),
    );
  }
}