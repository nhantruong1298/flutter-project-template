import 'package:flex_seed_scheme/flex_seed_scheme.dart';
import 'package:flutter/material.dart';

// Detail document: https://pub.dev/packages/flex_seed_scheme

const Color primarySeedColor = Color(0xFFA1C9FD);
const Color secondarySeedColor = Color(0xFFBBC7DB);
const Color tertiarySeedColor = Color(0xFFD7BDE4);

class AppScheme {

  static late ColorScheme colors;

  static configure(BuildContext context) {
    colors = _getScheme(context);
  }

  // Get ColorScheme based on the device's brightness
  static ColorScheme _getScheme(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.dark ? _dark : _light;
  }
  // Make a light ColorScheme from the seeds.
  static final ColorScheme _light = SeedColorScheme.fromSeeds(
    brightness: Brightness.light,
    // Primary key color is required, like seed color in ColorScheme.fromSeed.
    primaryKey: primarySeedColor,
    // You can add optional key colors as seeds for secondary and tertiary colors.
    secondaryKey: secondarySeedColor,
    tertiaryKey: tertiarySeedColor,
    // Tone chroma config and tone mapping is optional, if you do not add it
    // you get the config matching Flutter's Material 3 ColorScheme.fromSeed.
    tones: FlexTones.vivid(Brightness.light),
  );

// Make a dark ColorScheme from the same seed colors.
  static final ColorScheme _dark = SeedColorScheme.fromSeeds(
    brightness: Brightness.dark,
    primaryKey: primarySeedColor,
    secondaryKey: secondarySeedColor,
    tertiaryKey: tertiarySeedColor,
    tones: FlexTones.vivid(Brightness.dark),
  );
}

