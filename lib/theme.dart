import 'package:flutter/material.dart';

// ### Primary
//
// - Lime: hsl(61, 70%, 52%)
Color limeColor = const HSLColor.fromAHSL(1, 61, 0.7, 0.52).toColor();
// - Red: hsl(4, 69%, 50%)
Color redColor = const HSLColor.fromAHSL(1, 4, 0.69, 0.50).toColor();

//
// ### Neutral
//
// - White: hsl(0, 0%, 100%)
// - Slate 100: hsl(202, 86%, 94%)
// - Slate 300: hsl(203, 41%, 72%)
// - Slate 500: hsl(200, 26%, 54%)
// - Slate 700: hsl(200, 24%, 40%)
// - Slate 900: hsl(202, 55%, 16%)
//

Color mBlueColor = const Color.fromRGBO(227, 244, 252, 1);
Color mDarkBlueColor = const Color.fromRGBO(18, 48, 65, 1);

ThemeData getTheme(BuildContext context) {
  return ThemeData(
    fontFamily: 'PlusJakartaSans',
    textTheme: Theme.of(context).textTheme.copyWith(
        titleLarge: const TextStyle(
          fontWeight: FontWeight.w700,
        ),
        bodyMedium: const TextStyle(
          fontWeight: FontWeight.w400,
        )),
    colorScheme: Theme.of(context).colorScheme.copyWith(),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: limeColor,
        foregroundColor: const Color.fromRGBO(235, 238, 151, 1),
        overlayColor: const Color.fromRGBO(235, 238, 151, 1),
        shadowColor: Colors.transparent,
      ),
    ),
  );
}
