import 'package:flutter/material.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 1. WAJIB: GlobalKey buat Form
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // 2. WAJIB: State management pake setState
  bool isLoading = false;
  String? errorMessage;
  bool isPasswordVisible = false;

  // 3. WAJIB: Regex validasi
  final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final _passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');

  // 4. Fungsi Login
  Future<void> _login() async {
    // Validasi Form dulu
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true; // WAJIB: Munculin loading
      errorMessage = null;
    });

    // Simulasi loading 2 detik
    await Future.delayed(const Duration(seconds: 2));

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // 5. WAJIB: Mock credential admin@test.com / Admin123
    if (email == 'admin@test.com' && password == 'Admin123') {
      setState(() => isLoading = false);

      // 6. WAJIB: Snackbar sukses
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Berhasil!'),
          backgroundColor: Colors.green,
        ),
      );

      // 7. WAJIB: Navigasi ke Dashboard + kirim email
      Navigator.pushReplacementNamed(
        context,
        '/dashboard',
        arguments: email,
      );
    } else {
      setState(() {
        isLoading = false;
        errorMessage = 'Email atau password salah!'; // WAJIB: state errorMessage
      });

      // 6. WAJIB: Snackbar error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage!),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: Container(
            width: 400, // Tengah di web
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form( // WAJIB: Widget Form
                key: _formKey, // WAJIB: GlobalKey
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.lock, size: 80, color: Colors.indigo),
                    const SizedBox(height: 20),
                    const Text(
                      'Login App',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 40),

                    // WAJIB: TextFormField Email
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      // WAJIB: Validasi email
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email tidak boleh kosong';
                        }
                        if (!_emailRegex.hasMatch(value)) {
                          return 'Format email tidak valid';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // WAJIB: TextFormField Password
                    TextFormField(
                      controller: _passwordController,
                      obscureText:!isPasswordVisible, // WAJIB: toggle
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        // WAJIB: Toggle show/hide password
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible
                               ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() => isPasswordVisible =!isPasswordVisible);
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      // WAJIB: Validasi password
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password tidak boleh kosong';
                        }
                        if (value.length < 8) {
                          return 'Minimal 8 karakter';
                        }
                        if (!_passwordRegex.hasMatch(value)) {
                          return 'Harus ada huruf dan angka';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    // WAJIB: Tampil errorMessage
                    if (errorMessage!= null)
                      Text(
                        errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    const SizedBox(height: 12),

                    // WAJIB: Tombol Login + Loading
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.indigo,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: isLoading? null : _login,
                        child: isLoading
                           ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
                                'LOGIN',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // WAJIB: Tombol Lupa Password pake pushNamed
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/forgot');
                      },
                      child: const Text('Lupa Password?'),
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