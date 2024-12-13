// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:built_your_pc/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';
import '../services/auth_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final AuthProvider _auth = AuthProvider();
  final _picker = ImagePicker();
  File? _userProfile;

  Future<void> _pickProductPicture() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _userProfile = pickedFile != null ? File(pickedFile.path) : null;
    });
  }

  Future<User?> _register() async {
    final email = _emailController.text;
    final pass = _passwordController.text;
    final nama = _namaController.text;
    log(_userProfile.toString());
    String fullPath = await supabase.storage.from('profile').upload(
          basename(_userProfile!.path),
          _userProfile!,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
        );
    final url = fullPath.replaceFirst("profile", "");
    final user = await _auth.signUpWithPass(email, pass, nama, url);
    if (user != null) {
      return user;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 19, 19),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 50, 0, 70),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 19, 19, 19),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 58, 58, 58),
                    radius: 50,
                    backgroundImage:
                        _userProfile != null ? FileImage(_userProfile!) : null,
                    child: _userProfile == null
                        ? const Icon(
                            Icons.picture_in_picture,
                            size: 50,
                            color: Color.fromARGB(255, 207, 207, 207),
                          )
                        : null, // Tampilkan icon person jika belum ada foto
                  ),
                  const SizedBox(height: 16),
                  // Tombol Upload Foto
                  ElevatedButton(
                    onPressed: _pickProductPicture,
                    style: ElevatedButton.styleFrom(
                      elevation: 0.2,
                      backgroundColor: const Color.fromARGB(255, 54, 54, 54),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text(
                      'Upload Foto',
                      style: TextStyle(
                        color: Color.fromARGB(255, 231, 231, 231),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Tombol Upload Foto
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 8, 18, 8),
                    child: SizedBox(
                      child: TextField(
                        controller: _namaController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: const TextStyle(
                              color: Color.fromARGB(255, 75, 75, 75)),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Color.fromARGB(255, 20, 20, 20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 245, 182, 182)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          filled: true,
                          fillColor: const Color.fromARGB(255, 248, 248, 248),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 8, 18, 8),
                    child: SizedBox(
                      child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'E-mail',
                          labelStyle: const TextStyle(
                              color: Color.fromARGB(255, 75, 75, 75)),
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Color.fromARGB(255, 20, 20, 20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 245, 182, 182)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          filled: true,
                          fillColor: const Color.fromARGB(255, 248, 248, 248),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 8, 18, 8),
                    child: SizedBox(
                      child: TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: const TextStyle(
                              color: Color.fromARGB(255, 75, 75, 75)),
                          prefixIcon: const Icon(
                            Icons.lock_rounded,
                            color: Color.fromARGB(255, 20, 20, 20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color.fromARGB(255, 245, 182, 182)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          filled: true,
                          fillColor: const Color.fromARGB(255, 248, 248, 248),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Foto dalam bentuk lingkaran

                  // Tombol Register
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                          onPressed: () async {},
                          child: const Text(
                            'Register',
                            style: TextStyle(
                                fontFamily: 'Poppins-regular',
                                fontSize: 15,
                                color: Color.fromARGB(255, 29, 29, 29)),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            fixedSize:
                                WidgetStateProperty.all(const Size(150, 42)),
                            padding: WidgetStateProperty.all(
                                const EdgeInsets.fromLTRB(0, 0, 0, 0)),
                            backgroundColor: WidgetStateProperty.all(
                                const Color.fromARGB(255, 252, 252, 252)),
                            elevation: WidgetStateProperty.all(0),
                          ),
                          onPressed: () async {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              fontFamily: 'Poppins-Regular',
                              fontSize: 15,
                              color: Color.fromARGB(255, 32, 32, 32),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
