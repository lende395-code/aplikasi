import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>(); // 1. BUAT VALIDASI
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false; // 2. BUAT LOADING STATE

  Future<void> _sendResetLink() async {
    // 1. JALANIN VALIDASI EMAIL
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // 2. NYALAIN LOADING
    setState(() {
      _isLoading = true;
    });

    // Simulasi loading 2 detik kayak kirim email beneran
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    // 3. FEEDBACK VISUAL DIALOG
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Berhasil'),
        content: Text('Link reset telah dikirim ke ${_emailController.text}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Lupa Password'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        // 4. TOMBOL BACK OTOMATIS PAKE Navigator.pop
        automaticallyImplyLeading: true,
      ),
      // 5. SafeArea WAJIB BUAT NILAI
      body: SafeArea(
        child: Center(
          child: Container(
            width: 400, // BIAR NGGAK MELEBAR
            child: SingleChildScrollView(
              // 5. Padding WAJIB
              padding: const EdgeInsets.all(24),
              // 5. Column WAJIB
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.lock_reset,
                      size: 80,
                      color: Colors.indigo,
                    ),
                    // 5. SizedBox WAJIB
                    const SizedBox(height: 20),
                    const Text(
                      'Reset Password',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Masukkan email kamu untuk reset password',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 40),
                    // 1. TEXTFORMFIELD + VALIDASI EMAIL
                    TextFormField(
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email tidak boleh kosong';
                        }
                        if (!value.contains('@') ||!value.contains('.')) {
                          return 'Format email tidak valid';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // 2. TOMBOL DENGAN LOADING STATE
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
                        onPressed: _isLoading? null : _sendResetLink,
                        child: _isLoading
                           ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
                                'KIRIM LINK RESET',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // 4. TOMBOL KEMBALI KE LOGIN PAKE Navigator.pop
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Kembali ke Login'),
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