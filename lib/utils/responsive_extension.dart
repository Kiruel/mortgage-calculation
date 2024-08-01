import 'package:flutter/material.dart';

extension ResponsiveExtension on BuildContext {
  bool isMobile() => MediaQuery.of(this).size.width <= 720;
}
