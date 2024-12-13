// ignore_for_file: use_build_context_synchronously

import 'package:built_your_pc/pages/register.dart';
import 'package:built_your_pc/util/app_color.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isLoading ? bg : bg,
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 228, 228, 228),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 140, 0, 180),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 19, 19, 19),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 60,
                        ),
                        // Logo berbentuk lingkaran
                        const Text(
                          "Build\nYo PC",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromARGB(255, 226, 226, 226),
                              fontFamily: 'Poppins-Bold',
                              fontSize: 30),
                        ),
                        Icon(Icons.monitor_rounded),

                        const SizedBox(height: 40),
                        // TextField email dengan desain kapsul dan ikon email
                        SizedBox(
                          width: 300,
                          child: TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'E-mail',
                              labelStyle: const TextStyle(
                                  color: Color.fromARGB(255, 226, 226, 226)),
                              prefixIcon: const Icon(
                                Icons.email,
                                color: Color.fromARGB(255, 194, 194, 194),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 70, 70, 70)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 117, 117, 117)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 78, 78, 78)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              filled: true,
                              fillColor: const Color.fromARGB(255, 63, 63, 63),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // TextField password dengan ikon mata untuk menampilkan/menyembunyikan password
                        SizedBox(
                          width: 300,
                          child: TextField(
                            controller: _passwordController,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              iconColor: const Color.fromARGB(26, 168, 73, 73),
                              labelText: 'Password',
                              labelStyle: const TextStyle(
                                  color: Color.fromARGB(255, 218, 218, 218)),
                              prefixIcon: const Icon(Icons.lock,
                                  color: Color.fromARGB(255, 194, 194, 194)),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Color.fromARGB(255, 194, 194, 194),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 63, 63, 63)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 105, 105, 104),
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              filled: true,
                              fillColor: Color.fromARGB(255, 63, 63, 63),
                            ),
                          ),
                        ),

                        // Link Lupa Password di bawah isian Password
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Placeholder()),
                              );
                            },
                            child: const Text(
                              'Lupa Password?',
                              style: TextStyle(
                                  fontFamily: 'Poppins-Regular',
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Tombol login dan register dalam satu row
                        ElevatedButton(
                          style: ButtonStyle(
                            fixedSize:
                                WidgetStateProperty.all(const Size(240, 42)),
                            padding: WidgetStateProperty.all(
                                const EdgeInsets.fromLTRB(0, 0, 0, 0)),
                            backgroundColor: WidgetStateProperty.all(
                                const Color.fromARGB(255, 241, 68, 68)),
                            elevation: WidgetStateProperty.all(2),
                          ),
                          onPressed: () async {
                            String email = _emailController.text;
                            String password = _passwordController.text;
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                                fontFamily: 'Poppins-Regular',
                                color: Color.fromARGB(255, 243, 242, 242)),
                          ),
                        ),
                        const SizedBox(width: 16),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterPage()));
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                                fontFamily: 'Poppins-regular',
                                color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Login dengan sosial media
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
