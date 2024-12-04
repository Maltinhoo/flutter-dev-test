// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum Vectors {
  first_wave,
  second_wave,
  message_question,
}

class Vector extends StatelessWidget {
  final Vectors? vector;
  final String? url;
  final double? size;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? fit;
  final Alignment? alignment;
  final BlendMode? blendMode;
  const Vector(this.vector,
      {super.key,
      this.size,
      this.blendMode,
      this.color,
      this.fit,
      this.width,
      this.height,
      this.alignment})
      : url = null;

  const Vector.fromNetwork(
    this.url, {
    super.key,
    this.size,
    this.blendMode,
    this.color,
    this.fit,
    this.width,
    this.height,
    this.alignment,
  }) : vector = null;

  @override
  Widget build(BuildContext context) {
    if (vector == null && url == null) return Container();
    String fileName = vector?.name.toLowerCase() ?? '';
    String path = 'assets/icons/$fileName.svg';
    bool local = url == null;
    return local
        ? SvgPicture.asset(
            alignment: alignment ?? Alignment.center,
            path,
            fit: fit ?? BoxFit.cover,
            width: width ?? size,
            height: height ?? size,
            colorFilter: color != null
                ? ColorFilter.mode(
                    color ?? Colors.transparent, blendMode ?? BlendMode.srcIn)
                : null)
        : SvgPicture.network(url!,
            alignment: alignment ?? Alignment.center,
            fit: fit ?? BoxFit.cover,
            width: width ?? size,
            height: height ?? size,
            colorFilter: color != null
                ? ColorFilter.mode(
                    color ?? Colors.transparent, blendMode ?? BlendMode.srcIn)
                : null);
  }
}
