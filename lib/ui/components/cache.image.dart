import 'dart:math';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';

class CacheImage extends StatelessWidget {
  final String url;
  final double size;
  final bool hide;

  const CacheImage(
      {Key? key, required this.url, required this.size, this.hide = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (hide == true && !kIsWeb) {
      return Container(
        width: size,
        height: size,
        color: Color.fromRGBO(Random().nextInt(256), Random().nextInt(256),
            Random().nextInt(256), 0.1),
      );
    }
    return FadeIn(
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 500),
      child: ExtendedImage.network(
        url,
        width: size,
        height: size,
        cacheHeight: size ~/ 3,
        cacheWidth: size ~/ 3,
        clipBehavior: Clip.hardEdge,
        cache: true,
        enableLoadState: true,
        clearMemoryCacheWhenDispose: false,
        clearMemoryCacheIfFailed: true,
        enableMemoryCache: true,
        compressionRatio: 0.6,
        maxBytes: 200 << 10,
      ),
    );
  }
}
