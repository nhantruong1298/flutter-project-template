library app_resources;

import 'dart:async';

import 'package:app_resources/gen/preload.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

export './resources/all.dart';
export './widgets/typography/all.dart';
export './gen/all.dart';
export './localizations/all.dart';

class AppResource {
  static Future<void> preCacheImageAssets(BuildContext context) async {
    final svgList = PreLoadImages.svgList.map((asset) {
      final loader = SvgAssetLoader(asset.keyName);
      return svg.cache
          .putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
    }).toList();
    final rawList = PreLoadImages.imageList
        .map((asset) => precacheImage(AssetImage(asset.keyName), context))
        .toList();
    await Future.wait([...svgList, ...rawList]);

    return;
  }
}
