import 'package:flutter/material.dart';

class SongTileDraggableScrollSheetOptions extends StatefulWidget {
  const SongTileDraggableScrollSheetOptions({
    super.key, 
    required this.children, 
    required this.header, 
  }); 
  
  final Widget header; 
  final List<Widget> children; 

  @override
  State<SongTileDraggableScrollSheetOptions> createState() => _SongTileDraggableScrollSheetOptionsState();
}

class _SongTileDraggableScrollSheetOptionsState extends State<SongTileDraggableScrollSheetOptions> {

  DraggableScrollableController? draggableScrollableController; 
  ScrollController? scrollController; 
  final double minChildSize = 0; 
  final double maxChildSize = 0.65; 

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
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (DraggableScrollableNotification notification) {
        if (notification.extent <= 0) {
          Navigator.pop(context); 
          return true; 
        }
        return false; 
      },
      child: DraggableScrollableSheet(
        controller: draggableScrollableController, 
        initialChildSize: 0, 
        minChildSize: minChildSize, 
        maxChildSize: maxChildSize,
        builder: (BuildContext context, ScrollController controller) {
          return _SongTileDraggableScrollableSheetOptionsBody(
            controller: controller, 
            header: widget.header, 
            draggableScrollableController: draggableScrollableController!,
            maxChildSize: maxChildSize,
            children: widget.children, 
          ); 
        }
      ),
    );
  }
}

class _SongTileDraggableScrollableSheetOptionsBody extends StatelessWidget {
  const _SongTileDraggableScrollableSheetOptionsBody({
    Key? key,
    required this.header,
    required this.children, 
    required this.controller, 
    required this.draggableScrollableController, 
    required this.maxChildSize, 
  }) : super(key: key); 

  final Widget header; 
  final List<Widget> children; 
  final ScrollController controller; 
  final DraggableScrollableController draggableScrollableController; 
  final double maxChildSize; 

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(draggableScrollableController.isAttached){
        draggableScrollableController.animateTo(
          maxChildSize, 
          duration: const Duration(milliseconds: 400), 
          curve: Curves.fastEaseInToSlowEaseOut
        );
      }
    });
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(20), 
        topRight: Radius.circular(20), 
      ), 
      child: Container(
        color: Theme.of(context).primaryColor, 
        padding: const EdgeInsets.all(20),
        child: ListView(
          controller: controller, 
          children: [
            header, 
            ...children, 
          ], 
        ), 
      ), 
    ); 
  } 
} 

// class SongTileDraggableScrollSheetOptionsContent  extends StatelessWidget {
//   const SongTileDraggableScrollSheetOptionsContent ({
//     super.key
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       child: Column(
//         children: [

//         ],
//       ),
//     );
//   }
// }

// class SongTileDraggableScrollSheetOptionsTile extends StatelessWidget {
//   const SongTileDraggableScrollSheetOptionsTile({
//     super.key, 
//     required this.icon, 
//     required this.leading, 
//     this.onTap
//   }); 

//   final Widget icon; 
//   final String leading; 
//   final void Function()? onTap; 

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: SizedBox(
//         child: Row(
//           children: [
//             icon, 
//             Text(
//               leading, 
//               maxLines: 1,
//               style: Theme.of(context)
//                           .textTheme
//                           .titleMedium,
//             )
//           ],
//         )
//       ),
//     );
//   }
// }

