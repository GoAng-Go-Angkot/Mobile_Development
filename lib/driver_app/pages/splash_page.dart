import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  final _storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _startSplash();
  }

  Future<void> _startSplash() async {
    // Tampilkan splash selama 2 detik
    await Future.delayed(const Duration(seconds: 2));

    final token = await _storage.read(key: 'jwt');
    if (token != null) {
      context.goNamed('home');
    } else {
      context.goNamed('welcome');
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
      ),
    );

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF57A4FB),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: const Center(
          child: Image(
            image: AssetImage('assets/splash_page.png'),
            width: 150,
            height: 150,
          ),
        ),
      ),
    );
  }
}
