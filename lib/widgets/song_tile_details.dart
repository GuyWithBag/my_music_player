import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:my_music_player/widgets/widgets.dart';

class SongTileDetails extends StatelessWidget {
  const SongTileDetails({
    Key? key, 
    required this.header,
    required this.subHeader, 
    this.useMarquee = false, 
  }) : super(key: key);

  final String header; 
  final String subHeader; 
  final bool useMarquee; 

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Wrap(
          children: [
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Container(
                  width: 300, 
                  padding: const EdgeInsets.only(bottom: 5),
                  child: useMarquee == false ? Text(
                      header, 
                      maxLines: 2, 
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    )
                  : 
                    AutomaticMarqueeText(
                      marquee: Marquee(
                        text: header
                      ), 
                      context: context, 
                      text: header, 
                      maxWidth: constraints.maxWidth, 
                    ),
                );
              }
            ), 
            Text(
              subHeader, 
              maxLines: 2, 
              style: Theme.of(context)
                  .textTheme
                  .bodySmall,
            )
          ],
        ),
      ),
    );
  }
}