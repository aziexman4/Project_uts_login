import 'package:flutter/material.dart';
import 'login_page.dart'; // Impor halaman login

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        // Tema untuk semua TextField di dalam aplikasi
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFF2A2A2A),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            borderSide: BorderSide.none,
          ),
          hintStyle: TextStyle(color: Colors.grey),
        ),
        // Tema untuk latar belakang Scaffold
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      // Mulai aplikasi di LoginPage
      home: const LoginPage(),
    );
  }
}