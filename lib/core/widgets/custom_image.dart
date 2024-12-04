import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dev_test/app_imports.dart';

class CustomImage extends StatelessWidget {
  final bool local;
  final String imageUrl;
  final BoxFit? fit;
  final double? height;
  final double? width;
  final Widget Function(BuildContext, String)? placeholder;
  final Widget Function(BuildContext, String, dynamic)? errorWidget;
  final Alignment? alignment;
  final Color? color;
  final BlendMode? colorBlendMode;
  final double? opacity;
  final Widget Function(
    BuildContext,
    String,
    DownloadProgress,
  )? progressIndicatorBuilder;
  final BorderRadiusGeometry? borderRadius;
  const CustomImage({
    super.key,
    this.local = false,
    required this.imageUrl,
    this.fit,
    this.height,
    this.width,
    this.placeholder,
    this.errorWidget,
    this.alignment,
    this.progressIndicatorBuilder,
    this.color,
    this.colorBlendMode,
    this.opacity,
    this.borderRadius,
  });

  static List<String> reportedImageUrlsWithError = [];

  static void reportError(String imageUrl, exception, stackTrace) {
    if (reportedImageUrlsWithError.contains(imageUrl)) {
      return;
    }

    reportedImageUrlsWithError.add(imageUrl);

    if (kIsWeb) {
      debugPrint(
        'Error loading local image on web: $imageUrl',
      );

      return;
    } else {
      debugPrint(
        'Error loading local image: $imageUrl',
      );
    }
  }

  static Widget defaultErrorWidget() {
    return const Icon(Icons.image);
  }

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return SizedBox(
          height: height,
          width: width,
          child: errorWidget != null
              ? errorWidget!(context, '', '')
              : defaultErrorWidget());
    }
    if (local) {
      return Opacity(
        opacity: opacity ?? 1,
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.circular(0),
          child: Image.asset(
            imageUrl,
            fit: fit,
            alignment: alignment ?? Alignment.center,
            height: height,
            width: width,
            filterQuality: FilterQuality.high,
            errorBuilder: (context, obj, stack) {
              return errorWidget != null
                  ? errorWidget!(context, obj.toString(), stack)
                  : defaultErrorWidget();
            },
            color: color,
            colorBlendMode: colorBlendMode,
          ),
        ),
      );
    }

    return Opacity(
      opacity: opacity ?? 1,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(0),
        child: CachedNetworkImage(
          filterQuality: FilterQuality.high,
          imageUrl: imageUrl.isNotEmpty ? imageUrl : '',
          fit: fit,
          height: height,
          alignment: alignment ?? Alignment.center,
          width: width,
          placeholder: (context, url) {
            return placeholder != null
                ? placeholder!(context, url)
                : SkeletonShimmer(
                    height: height ?? 100,
                    width: width ?? 100,
                    borderRadius: borderRadius,
                  );
          },
          errorWidget: (context, obj, stack) {
            reportError(imageUrl, obj, stack);
            return errorWidget != null
                ? errorWidget!(context, obj, stack)
                : defaultErrorWidget();
          },
          progressIndicatorBuilder: progressIndicatorBuilder,
          color: color,
          colorBlendMode: colorBlendMode,
        ),
      ),
    );
  }
}
