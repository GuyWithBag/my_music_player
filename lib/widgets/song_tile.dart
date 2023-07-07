import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/widgets.dart'; 

// This Widget is reused as a template for other tiles so that i do not have to rewrite code. 
// This is created for reusability. 

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    this.index = -1, 
    required this.onTap, 
    required this.thumbnail, 
    required this.thumbnailSize, 
    required this.thumbnailBorderRadius, 
    required this.containerHeight, 
    required this.details, 
  });

  final void Function() onTap; 

  final Widget details; 

  final Widget thumbnail; 
  final double thumbnailSize; 
  final double thumbnailBorderRadius; 

  final double containerHeight; 
  final int index; 


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: containerHeight, 
        margin: const EdgeInsets.only(bottom: 10), 
        padding: const EdgeInsets.symmetric(horizontal: 20), 
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0), 
        ), 
        child: Row(
          children: [
            SongThumbnail(
              thumbnail: thumbnail,
              height: thumbnailSize,
              width: thumbnailSize,
              borderRadius: thumbnailBorderRadius,
            ), 
            const SizedBox(width: 15), 
            details, 
            const Center(
              child: _MoreButton()
            ), 
            index <= -1 ? 
              const SizedBox()
            : 
            ReorderableDragStartListener(
                index: index, 
                child: const Icon(CupertinoIcons.equal), 
            )
          ],
        ),
      ),
    );
  }
}

class _MoreButton extends StatelessWidget {
  const _MoreButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: const SizedBox(
        child: Icon(Icons.more_vert)
      ),
    );
  }
}