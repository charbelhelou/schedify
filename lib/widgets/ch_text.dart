import 'package:flutter/material.dart';

class CHText extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const CHText(this.text,
      {Key? key,
      this.fontColor,
      this.fontSize,
      this.fontWeight,
      this.textAlign,
      this.maxLines = 100,
      this.lineHeight = 1,
      this.fontFamily,
      this.letterSpacing,
      this.shadows});

  final String? text;

  final Color? fontColor;
  final double? fontSize;
  final String? fontFamily;

  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final double lineHeight;
  final double? letterSpacing;

  final List<Shadow>? shadows;

  @override
  State<CHText> createState() => _CHTextState();
}

class _CHTextState extends State<CHText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text ?? "",
      maxLines: widget.maxLines,
      textAlign: widget.textAlign,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          shadows: widget.shadows,
          fontFamily: widget.fontFamily,
          height: widget.lineHeight,
          letterSpacing: widget.letterSpacing ?? 0.25,
          color: widget.fontColor,
          fontSize: widget.fontSize,
          fontWeight: widget.fontWeight),
    );
  }
}
