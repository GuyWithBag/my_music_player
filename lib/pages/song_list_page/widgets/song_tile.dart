import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'; 

// This Widget is reused as a template for other tiles so that i do not have to rewrite code. 
// This is created for reusability. 

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    required this.onTap, 
    required this.header,
    required this.subHeader,
    required this.thumbnail, 
    required this.thumbnailSize, 
    required this.thumbnailBorderRadius, 
    required this.containerHeight, 
    this.index = -1, 
  });

  final void Function() onTap; 

  final String header; 
  final String subHeader; 

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
            _SongThumbnail(
              thumbnail: thumbnail,
              thumbnailSize: thumbnailSize,
              thumbnailBorderRadius: thumbnailBorderRadius,
            ), 
            const SizedBox(width: 15), 
            _Details(
              header: header,
              subHeader: subHeader,
            ), 
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

class _SongThumbnail extends StatelessWidget {
  const _SongThumbnail({
    Key? key, 
    required this.thumbnail, 
    required this.thumbnailSize, 
    required this.thumbnailBorderRadius, 
  }) : super(key: key); 

  final Widget thumbnail; 
  final double thumbnailSize; 
  final double thumbnailBorderRadius; 

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(thumbnailBorderRadius), 
      child: Container(
        color: Colors.grey, 
        alignment: Alignment.center, 
        height: thumbnailSize,
        width: thumbnailSize, 
        child: thumbnail
      ),
    );
  }
}

class _Details extends StatelessWidget {
  const _Details({
    Key? key, 
    required this.header,
    required this.subHeader,
  }) : super(key: key);

  final String header; 
  final String subHeader; 

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Wrap(
          children: [
            Container(
              width: 300, 
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                header, 
                maxLines: 2, 
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
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
