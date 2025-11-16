import 'package:flutter/material.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // State untuk password visibility
  bool _isPasswordVisible = false;
  
  // State untuk loading
  bool _isLoading = false;

  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Fungsi utama untuk logika login
  Future<void> _login() async {
    // 1. Mulai loading
    setState(() {
      _isLoading = true;
    });

    // 2. Simulasikan proses login ke server (delay 2 detik)
    // Ini untuk meniru proses pengecekan ke database
    await Future.delayed(const Duration(seconds: 2));

    // --- Logika Cek Login ---
    const String correctEmail = 'admin@gmail.com';
    const String correctPassword = 'admin123';

    final String name = _nameController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;

    // 3. Cek hasil login
    if (email == correctEmail && password == correctPassword) {
      // Jika BERHASIL: Pindah ke HomePage
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(name: name.isEmpty ? "Admin" : name),
          ),
        );
      }
    } else {
      // Jika GAGAL: Tampilkan notifikasi error
      if (mounted) {
        _showErrorNotification("Email atau Password Salah");
      }
    }

    // 4. Hentikan loading (jika widget masih ada)
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Widget untuk notifikasi error
  void _showErrorNotification(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // AbsorbPointer menonaktifkan semua input saat loading
    return AbsorbPointer(
      absorbing: _isLoading,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1E1E1E), Color(0xFF121212)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // Bagian Header
                    const Text(
                      'Welcome Back',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sign in to continue',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey[400]),
                    ),
                    const SizedBox(height: 48),

                    // TextField untuk Nama
                    TextField(
                      controller: _nameController,
                      enabled: !_isLoading, // Nonaktifkan saat loading
                      keyboardType: TextInputType.name,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person_outline, color: Colors.grey),
                        hintText: 'Enter your name (Optional)',
                      ),
                    ),
                    const SizedBox(height: 20),

                    // TextField untuk Email
                    TextField(
                      controller: _emailController,
                      enabled: !_isLoading, // Nonaktifkan saat loading
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email_outlined, color: Colors.grey),
                        hintText: 'Email (admin@gmail.com)',
                      ),
                    ),
                    const SizedBox(height: 20),

                    // TextField untuk Password
                    TextField(
                      controller: _passwordController,
                      enabled: !_isLoading, // Nonaktifkan saat loading
                      obscureText: !_isPasswordVisible,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outline, color: Colors.grey),
                        hintText: 'Password (admin123)',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Tombol "Forgot Password?"
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: _isLoading ? null : () {}, // Nonaktifkan saat loading
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Tombol Login
                    ElevatedButton(
                      onPressed: _isLoading ? null : _login, // Panggil _login
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      // Tampilkan loading spinner atau teks
                      child: _isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              ),
                            )
                          : const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                    const SizedBox(height: 32),

                    // Baris untuk "Sign Up"
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                        GestureDetector(
                          onTap: _isLoading ? null : () {}, // Nonaktifkan saat loading
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}