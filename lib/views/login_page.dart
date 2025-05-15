import 'package:flutter/material.dart';
import 'package:presensi_flutter_test/services/auth/login.dart';
import 'package:presensi_flutter_test/models/login_request.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;
  bool rememberMe = false;

  bool isLoading = false;
  String? errorMessage;

  void handleLogin() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final loginRequest = LoginRequest(
      id: idController.text.trim(),
      password: passwordController.text.trim(),
    );

    try {
      final token = await login(loginRequest);

      print('Login berhasil. Token: $token');
    } catch (e) {
      setState(() {
        errorMessage = 'Login gagal: ${e.toString()}';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade700,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/images/gambar.png',
                height: 200, fit: BoxFit.cover),
            const SizedBox(height: 16),
            const Text('Welcome Back',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            const SizedBox(height: 24),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Login to your account',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  const Text('ID Siswa'),
                  const SizedBox(height: 6),
                  TextField(
                    controller: idController,
                    decoration: InputDecoration(
                      hintText: 'Masukkan ID Siswa',
                      fillColor: Colors.grey[200],
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text('Password'),
                  const SizedBox(height: 6),
                  TextField(
                    controller: passwordController,
                    obscureText: obscurePassword,
                    decoration: InputDecoration(
                      hintText: 'Masukkan Password',
                      fillColor: Colors.grey[200],
                      filled: true,
                      suffixIcon: IconButton(
                        icon: Icon(obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () =>
                            setState(() => obscurePassword = !obscurePassword),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none),
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: rememberMe,
                          onChanged: (val) =>
                              setState(() => rememberMe = val!)),
                      const Text('Remember me'),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Forgot Password',
                            style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : handleLogin,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text('Login'),
                    ),
                  ),
                  if (errorMessage != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ]
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
