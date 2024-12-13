// ignore_for_file: use_build_context_synchronously

import 'package:built_your_pc/pages/register.dart';
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
      backgroundColor:
          _isLoading ? Colors.white : const Color.fromARGB(255, 255, 255, 250),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 255, 238, 0),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 180, 0, 180),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
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
                          "HeavyHub",
                          style: TextStyle(
                              fontFamily: 'Poppins-Bold', fontSize: 30),
                        ),

                        const SizedBox(height: 40),
                        // TextField email dengan desain kapsul dan ikon email
                        SizedBox(
                          width: 300,
                          child: TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'E-mail',
                              labelStyle: const TextStyle(
                                  color: Color.fromARGB(255, 75, 75, 75)),
                              prefixIcon: const Icon(
                                Icons.email,
                                color: Color.fromARGB(255, 17, 17, 17),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 255, 230, 0)),
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
                              fillColor:
                                  const Color.fromARGB(255, 248, 248, 248),
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
                                  color: Color.fromARGB(255, 75, 75, 75)),
                              prefixIcon: const Icon(Icons.lock,
                                  color: Color.fromARGB(255, 17, 17, 17)),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: const Color.fromARGB(255, 15, 15, 15),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 255, 230, 0),
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
                              fillColor:
                                  const Color.fromARGB(255, 248, 248, 248),
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
                                const Color.fromARGB(255, 255, 238, 0)),
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
                                color: Color.fromARGB(255, 20, 20, 20)),
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
