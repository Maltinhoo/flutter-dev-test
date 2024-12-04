// ignore_for_file: constant_identifier_names

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final FontWeight? fontWeight;
  final double? size;

  final Color? color;
  final String? fontFamily;

  final TextAlign? textAlign;

  final int? maxLines;
  final EdgeInsets? margin;
  final EdgeInsets padding;

  final ConversionType conversion;

  final bool autosize;
  final AutoSizeGroup? group;

  const CustomText(
    this.text, {
    super.key,
    this.textStyle,
    this.fontWeight,
    this.size,
    this.color,
    this.fontFamily,
    this.textAlign,
    this.maxLines,
    this.margin,
    this.padding = const EdgeInsets.all(0),
    this.conversion = ConversionType.None,
    this.autosize = true,
    this.group,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle? style;
    if (textStyle != null) {
      style = textStyle!;
    }

    style ??= Theme.of(context).textTheme.bodyLarge!;

    style = GoogleFonts.plusJakartaSans().copyWith(
      fontSize: size ?? style.fontSize,
      color: color ?? style.color,
      fontFamily: fontFamily ?? style.fontFamily,
      fontWeight: fontWeight ?? style.fontWeight,
    );

    return Padding(
      padding: margin ?? padding,
      child: _buildText(style),
    );
  }

  String get getText {
    switch (conversion) {
      case ConversionType.ToUpperCase:
        return text.toUpperCase();
      case ConversionType.ToLowerCase:
        return text.toLowerCase();
      case ConversionType.Capitalize:
        return text.capitalize();
      default:
        return text;
    }
  }

  Widget _buildText(TextStyle? style) {
    var textWidget = autosize
        ? AutoSizeText(
            getText,
            style: style,
            textAlign: textAlign,
            maxLines: maxLines,
            group: group,
          )
        : Text(
            getText,
            style: style,
            textAlign: textAlign,
            maxLines: maxLines,
          );

    return textWidget;
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

enum ConversionType {
  ToUpperCase,
  ToLowerCase,
  Capitalize,
  None,
}
