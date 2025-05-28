import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});
  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    final success = await ref.read(authProvider.notifier).login(
          email: _emailCtrl.text.trim(),
          password: _passwordCtrl.text,
        );
    if (success) {
      context.go('/home');
    } else {
      final err = ref.read(authProvider).error ?? 'Login gagal';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(err)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authProvider);
    const fieldHeight = 50.0;
    const radius = BorderRadius.all(Radius.circular(12));
    const btnHeight = 50.0;
    const btnRadius = BorderRadius.all(Radius.circular(25));

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF57A4FB), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                const SizedBox(height: 24),
                ///////// Judul Login
                Text(
                  'Login',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                //////// Gambar
                Center(
                  child: Image.asset(
                    'assets/login.gif',
                    width: 180,
                    height: 180,
                  ),
                ),
                const SizedBox(height: 32),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Label + Email field
                      const Text('Email', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                      const SizedBox(height: 4),
                      SizedBox(
                        height: fieldHeight,
                        child: TextFormField(
                          controller: _emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Masukan Email',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: radius,
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Email wajib';
                            if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v)) {
                              return 'Format email tidak valid';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Label + Password field
                      const Text('Password', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                      const SizedBox(height: 4),
                      SizedBox(
                        height: fieldHeight,
                        child: TextFormField(
                          controller: _passwordCtrl,
                          obscureText: _obscure,
                          decoration: InputDecoration(
                            hintText: 'Masukan Password',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: radius,
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                            suffixIcon: IconButton(
                              icon: Icon(_obscure ? Icons.visibility_off : Icons.visibility),
                              onPressed: () => setState(() => _obscure = !_obscure),
                            ),
                          ),
                          validator: (v) => v == null || v.isEmpty ? 'Password wajib' : null,
                        ),
                      ),
                      const SizedBox(height: 32),
                      // Tombol Masuk
                      ElevatedButton(
                        onPressed: state.isLoading ? null : _onSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF37A4FB),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          minimumSize: const Size(double.infinity, btnHeight),
                          shape: RoundedRectangleBorder(borderRadius: btnRadius),
                        ),
                        child: state.isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text('Masuk'),
                      ),
                      const SizedBox(height: 16),
                      // Footer link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Tidak mempunyai akun? ',
                            style: TextStyle(color: Colors.black),
                          ),
                          GestureDetector(
                            onTap: () => context.goNamed('register'),
                            child: const Text(
                              'Daftar disini',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF0051FF),
                                decoration: TextDecoration.underline,
                                decorationColor: const Color(0xFF0051FF), 
                                decorationThickness: 2.0,
                                decorationStyle: TextDecorationStyle.solid,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
