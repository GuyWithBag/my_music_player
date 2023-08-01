import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/domain.dart';

class CategorizedResultsHeader extends StatelessWidget {
  const CategorizedResultsHeader({
    super.key, 
    required this.title, 
    required this.data
  }); 

  final String title; 
  final List<HasNameObject> data; 

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.5), 
        boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3), 
              offset: const Offset(0, 10), 
              blurRadius: 6, 
            
          ), 
        ]
      ), 
      height: 50,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20, 
          vertical: 10
        ),
        child: Row(
          children: [
            Text(
              title, 
              style: Theme.of(context)
                          .textTheme
                          .titleMedium,
            ), 
            const Spacer(), 
            InkWell(
              onTap: () {
                Get.toNamed(
                  "SearchResults/SeeMore", 
                  arguments: SearchResultsSeeMoreArguments(data), 
                ); 
              },
              child: Text(
                "See More", 
                style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(
                            fontWeight: FontWeight.bold, 
                          ),
              ),
            )
          ],
        ),
      ),
    );
  }
}