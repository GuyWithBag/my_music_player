import 'package:flutter/cupertino.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';

import '../domain/domain.dart';

class SongBuilder extends StatelessWidget {
  const SongBuilder({
    super.key, 
    required this.song, 
    required this.builder
  });

  final Song? song; 
  final Widget Function(BuildContext, Metadata?) builder; 

  @override
  Widget build(BuildContext context) {
    if (song == null) {
        return FutureBuilder(
        builder: (BuildContext context, AsyncSnapshot<Metadata> snapshot) {
          return builder(context, snapshot.data); 
        }
      ); 
    }
    return FutureBuilder(
      future: song!.getMetadata(),
      builder: (BuildContext context, AsyncSnapshot<Metadata> snapshot) {
        return builder(context, snapshot.data); 
      }
    ); 
  }
}


