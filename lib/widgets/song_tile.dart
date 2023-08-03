import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/widgets.dart';

// This Widget is reused as a template for other tiles so that i do not have to rewrite code. 
// This is created for reusability. 

class SongTile extends StatelessWidget {
  const SongTile({
    super.key,
    this.index = -1, 
    required this.onPressed, 
    required this.thumbnailBorderRadius, 
    required this.details, 
    this.thumbnail, 
    this.thumbnailSize, 
    this.containerHeight, 
    this.reOrderable = true, 
    this.showMoreButton = true, 
    this.actions, 
    this.onMoreButtonPressed, 
    this.onSelected, 
    this.selectable = false, 
    this.selected = false, 
    this.decoration, 
  });

  final void Function() onPressed; 
  final void Function()? onMoreButtonPressed; 
  final void Function()? onSelected; 

  final bool selected; 

  final Widget details; 

  final Widget? thumbnail; 
  final double? thumbnailSize; 
  final double thumbnailBorderRadius; 

  final double? containerHeight; 
  final int index; 
  final bool reOrderable; 
  final bool showMoreButton; 
  final bool selectable; 
  final List<Widget>? actions; 

  final Decoration? decoration; 

  List<Widget> _placeActions() {
    if (actions != null) {
      return actions!; 
    }
    return <Widget>[const SizedBox()]; 
  }

  Decoration? _boxDecoration() {
    if (selected) {
      return BoxDecoration(
        color: selected ? Colors.white.withOpacity(0.2) : null, 
      );
    } else if (decoration != null) {
      return decoration; 
    }
    return null; 
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, 
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(Colors.transparent), 
        elevation: MaterialStatePropertyAll<double>(0), 
      ),
      child: Container(
        height: containerHeight, 
        margin: const EdgeInsets.only(bottom: 10), 
        decoration: _boxDecoration(), 
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
            Row(
              children: [
                ..._placeActions(), 
                Visibility(
                  visible: showMoreButton, 
                  child: _MoreButton(
                    onPressed: onMoreButtonPressed
                  ),
                ), 
                Visibility(
                  visible: index > -1,
                  child: Visibility(
                    visible: reOrderable, 
                    child: ReorderableDragStartListener(
                        index: index, 
                        child: const Icon(CupertinoIcons.equal), 
                    ),
                  ), 
                ), 
                Visibility(
                  visible: selectable, 
                  child: IconButton(
                    icon: selected ? const Icon(Icons.check_circle) : const Icon(Icons.circle_outlined), 
                    onPressed: onSelected,
                  )
                )
              ]
            ), 
          ],
        ),
      ),
    );
  }
}

class _MoreButton extends StatelessWidget {
  const _MoreButton({
    Key? key, 
    required this.onPressed, 
  }) : super(key: key);

  final void Function()? onPressed; 

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.more_vert), 
    ); 
  }
}