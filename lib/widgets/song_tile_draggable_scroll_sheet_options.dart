import 'package:flutter/material.dart';
import 'package:my_music_player/domain/domain.dart';


class SongTileDraggableScrollSheetOptions extends StatelessWidget {
  const SongTileDraggableScrollSheetOptions({
    super.key, 
    required this.draggableScrollableController, 
    required this.children, 
  }); 

  final DraggableScrollableController draggableScrollableController; 
  final List<Widget> children; 

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: draggableScrollableController,
      builder: (BuildContext context, ScrollController scrollController) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8), 
            topRight: Radius.circular(8), 
          ),
          child: Container(
            color: Theme.of(context).primaryColor, 
            padding: const EdgeInsets.all(20),
            child: ListView(
              controller: scrollController, 
              children: children, 
            ),
          ),
        ); 
      }
    );
  }
}

class SongTileDraggableScrollSheetOptionsContent  extends StatelessWidget {
  const SongTileDraggableScrollSheetOptionsContent ({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [

        ],
      ),
    );
  }
}

class SongTileDraggableScrollSheetOptionsTile extends StatelessWidget {
  const SongTileDraggableScrollSheetOptionsTile({
    super.key, 
    required this.icon, 
    required this.leading, 
    this.onTap
  }); 

  final Widget icon; 
  final String leading; 
  final void Function()? onTap; 

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        child: Row(
          children: [
            icon, 
            Text(
              leading, 
              maxLines: 1,
              style: Theme.of(context)
                          .textTheme
                          .titleMedium,
            )
          ],
        )
      ),
    );
  }
}

