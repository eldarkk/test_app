import 'package:flutter/material.dart';
import 'package:test_app/core/theme/main_theme.dart';
import 'package:test_app/injection_container.dart';
import 'package:test_app/router.dart';

void main() async {
  initDi();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: 'Test App',
      theme: appTheme,
      themeMode: ThemeMode.system,
      locale: const Locale('en'),
      supportedLocales: const [Locale('en')],
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: child!,
        );
      },
    );
  }
}
