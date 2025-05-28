import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const buttonHeight = 50.0;
    final buttonRadius = BorderRadius.circular(30);

    return Scaffold(
      body: Container(
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
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 80),
            Center(
              child: Image.asset(
                'assets/driver_welcome.gif',
                width: 200,
                height: 200,
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Selamat Datang di ',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Text(
              'GoAng!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Aplikasi pelacak angkot berbasis map',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 60),
            //////// Tombol Daftar
            ElevatedButton(
              onPressed: () => context.goNamed('register'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF37A4FB),
                foregroundColor: Colors.white,
                elevation: 0,
                minimumSize: const Size(double.infinity, buttonHeight),
                shape: RoundedRectangleBorder(borderRadius: buttonRadius),
              ),
              child: const Text('Daftar'),
            ),
            const SizedBox(height: 16),
            ///////// Tombol Masuk
            ElevatedButton(
              onPressed: () => context.goNamed('login'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF37A4FB),
                foregroundColor: Colors.white,
                elevation: 0,
                minimumSize: const Size(double.infinity, buttonHeight),
                shape: RoundedRectangleBorder(borderRadius: buttonRadius),
              ),
              child: const Text('Masuk'),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
