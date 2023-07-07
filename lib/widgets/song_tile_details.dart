import 'package:flutter/material.dart';

class SongTileDetails extends StatelessWidget {
  const SongTileDetails({
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