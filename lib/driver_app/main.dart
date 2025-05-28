import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'routes.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "../.env"); // <-- muat dotenv dulu
  runApp(const ProviderScope(child: GoAngDriverApp()));
}

class GoAngDriverApp extends ConsumerWidget {
  const GoAngDriverApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final router = GoRouter(
      initialLocation: '/',
      routes: routes,
    );

    return MaterialApp.router(
      title: 'GoAng Driver',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
