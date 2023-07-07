import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import '../domain/domain.dart'; 

class AutomaticMarqueeText extends StatelessWidget {
  const AutomaticMarqueeText({
    Key? key, 
    required this.marquee, 
    required this.context, 
    required this.text, 
    required this.maxWidth, 
    this.style, 
    this.textAlign, 
    this.maxLines
  }) : super(key: key); 

  final Marquee marquee; 
  final BuildContext context; 
  final String text; 
  final double maxWidth; 
  final TextStyle? style; 
  final TextAlign? textAlign; 
  final int? maxLines; 
  
  Widget getMarquee({required String text, required double maxWidth, required BuildContext context, TextDirection textDirection = TextDirection.ltr}) {
    TextSpan textSpan = TextSpan(text: text, style: style); 
    double textWidth = getTextWidth(textSpan: textSpan); 
    double textHeight = getTextHeight(textSpan: textSpan); 
    if (textWidth >= maxWidth) {
      return SizedBox(
        height: textHeight,
        child: marquee
      ); 
    }
    return Text(
      text, 
      maxLines: maxLines, 
      style: style, 
      textAlign: textAlign, 
    ); 
  }

  @override
  Widget build(BuildContext context) {
    return getMarquee(
      text: text, 
      maxWidth: maxWidth, 
      context: context
    );
  }
}