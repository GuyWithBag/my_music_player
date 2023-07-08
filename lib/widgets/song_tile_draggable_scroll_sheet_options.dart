import 'package:flutter/material.dart';

class SongTileDraggableScrollSheetOptions extends StatefulWidget {
  const SongTileDraggableScrollSheetOptions({
    super.key, 
    required this.children, 
    required this.visible, 
  }); 

  final List<Widget> children; 
  final bool visible; 

  @override
  State<SongTileDraggableScrollSheetOptions> createState() => _SongTileDraggableScrollSheetOptionsState();
}

class _SongTileDraggableScrollSheetOptionsState extends State<SongTileDraggableScrollSheetOptions> {

  DraggableScrollableController? draggableScrollableController; 
  ScrollController? scrollController; 
  final double minChildSize = 0; 
  final double maxChildSize = 0.5; 

  @override
  void initState() {
    draggableScrollableController ??= DraggableScrollableController(); 
    super.initState();
  }
  
  @override
  void dispose() {
    draggableScrollableController!.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.visible, 
      child: TweenAnimationBuilder(
        tween: Tween<double>(
          begin: minChildSize, 
          end: maxChildSize
        ),
        duration: const Duration(milliseconds: 7), 
        child: _SongTileDraggableScrollableSheetOptiosBody(
          scrollController: scrollController,
          children: widget.children, 
        ),
        builder: (BuildContext context, double value, Widget? child) {
          return DraggableScrollableSheet(
            controller: draggableScrollableController, 
            initialChildSize: value, 
            minChildSize: minChildSize, 
            maxChildSize: maxChildSize,
            builder: (BuildContext context, ScrollController controller) {
              scrollController = controller; 
              return child!; 
            }
          );
        }
      ),
    );
  }
}

class _SongTileDraggableScrollableSheetOptiosBody extends StatelessWidget {
  const _SongTileDraggableScrollableSheetOptiosBody({
    Key? key,
    required this.children, 
    required this.scrollController,
  }) : super(key: key); 

  final List<Widget> children; 
  final ScrollController? scrollController; 

  @override
  Widget build(BuildContext context) {
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

