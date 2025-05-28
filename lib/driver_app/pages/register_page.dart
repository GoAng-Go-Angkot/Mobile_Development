import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});
  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  String? _selectedRoute;
  bool _obscurePwd = true;
  bool _obscureConfirm = true;

  final List<String> _routes = [
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
  ];

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await ref.read(authProvider.notifier).register(
      username: _usernameCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      password: _passwordCtrl.text,
      route: _selectedRoute ?? '',
    );
    if (success) {
      context.goNamed('login');
    } else {
      final err = ref.read(authProvider).error ?? 'Register gagal';
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(err)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authProvider);
    const fieldHeight = 50.0;
    const borderRadius = Radius.circular(12);
    const btnHeight = 50.0;
    const btnRadius = Radius.circular(25);

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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                /////////// Judul
                Text(
                  'Daftar',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                ////////// Gambar
                Center(
                  child: Image.asset(
                    'assets/register.gif',
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
                      /////////// Username
                      const Text('Username', style: TextStyle(color: Colors.black)),
                      const SizedBox(height: 4),
                      SizedBox(
                        height: fieldHeight,
                        child: TextFormField(
                          controller: _usernameCtrl,
                          decoration: InputDecoration(
                            hintText: 'Masukan Username',
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(borderRadius),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Username wajib' : null,
                        ),
                      ),
                      const SizedBox(height: 16),

                      //////////// Email
                      const Text('Email', style: TextStyle(color: Colors.black)),
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
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(borderRadius),
                              borderSide: BorderSide.none,
                            ),
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

                      /////////// Password
                      const Text('Password', style: TextStyle(color: Colors.black)),
                      const SizedBox(height: 4),
                      SizedBox(
                        height: fieldHeight,
                        child: TextFormField(
                          controller: _passwordCtrl,
                          obscureText: _obscurePwd,
                          decoration: InputDecoration(
                            hintText: 'Masukan Password',
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(borderRadius),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(_obscurePwd
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () =>
                                  setState(() => _obscurePwd = !_obscurePwd),
                            ),
                          ),
                          validator: (v) =>
                              v == null || v.isEmpty ? 'Password wajib' : null,
                        ),
                      ),
                      const SizedBox(height: 16),

                      //////////// Confirm Password
                      const Text('Ulangi Password', style: TextStyle(color: Colors.black)),
                      const SizedBox(height: 4),
                      SizedBox(
                        height: fieldHeight,
                        child: TextFormField(
                          controller: _confirmCtrl,
                          obscureText: _obscureConfirm,
                          decoration: InputDecoration(
                            hintText: 'Masukan Ulang Password',
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(borderRadius),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(_obscureConfirm
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () =>
                                  setState(() => _obscureConfirm = !_obscureConfirm),
                            ),
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Ulangi password wajib';
                            if (v != _passwordCtrl.text) return 'Password tidak sama';
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 16),

                      /////////////// Dropdown Rute
                      const Text('Pilih Rute', style: TextStyle(color: Colors.black)),
                      const SizedBox(height: 4),
                      SizedBox(
                        height: fieldHeight,
                        child: DropdownButtonFormField<String>(
                          value: _selectedRoute,
                          hint: const Text('Pilih Rute Angkot'),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(borderRadius),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          items: _routes
                              .map((r) => DropdownMenuItem(value: r, child: Text(r)))
                              .toList(),
                          onChanged: (v) => setState(() => _selectedRoute = v),
                          validator: (v) => v == null ? 'Rute wajib dipilih' : null,
                        ),
                      ),
                      const SizedBox(height: 32),

                      ////////////// Tombol Daftar
                      ElevatedButton(
                        onPressed: state.isLoading ? null : _onSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF37A4FB),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          minimumSize: const Size(double.infinity, btnHeight),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(btnRadius),
                          ),
                        ),
                        child: state.isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text('Daftar'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
