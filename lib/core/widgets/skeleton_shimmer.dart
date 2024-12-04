import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonShimmer extends StatelessWidget {
  final double height;
  final double width;
  final double radius;
  final BorderRadiusGeometry? borderRadius;
  final Widget? child;
  final bool enabled;

  const SkeletonShimmer({
    super.key,
    this.height = 18,
    this.width = 100,
    this.radius = 2,
    this.borderRadius,
    this.child,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return child ?? Container();
    }
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: Container(
          height: height,
          width: width,
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: borderRadius ?? BorderRadius.circular(radius),
          ),
        ));
  }
}
