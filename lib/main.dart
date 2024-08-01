import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mortgage_flutter/theme.dart';
import 'package:mortgage_flutter/utils/responsive_extension.dart';
import 'package:mortgage_flutter/views/desktop_view.dart';
import 'package:mortgage_flutter/views/mobile_view.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        locale: const Locale('en', 'US'),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
        ],
        theme: getTheme(context),
        home: Scaffold(
          backgroundColor: context.isMobile() ? Colors.white : mBlueColor,
          body: LayoutBuilder(builder: (context, boxConstraints) {
            if (boxConstraints.maxWidth <= 730) {
              return const MobileView();
            } else {
              return const DesktopView();
            }
          }),
        ),
      ),
    );
  }
}
