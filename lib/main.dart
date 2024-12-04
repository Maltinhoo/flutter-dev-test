import 'package:flutter/material.dart';
import 'package:flutter_dev_test/app_imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator.initServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();
    return MaterialApp.router(
      title: 'Dev Flutter Test',
      scaffoldMessengerKey: GoRouterSystem.scaffoldKey,
      routerConfig: GoRouterSystem.router,
      theme: ThemeData(
        useMaterial3: false,
        progressIndicatorTheme: const ProgressIndicatorThemeData(),
      ),
      builder: (context, child) {
        child = botToastBuilder(context, child);
        return child;
      },
    );
  }
}
