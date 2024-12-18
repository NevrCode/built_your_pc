// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:built_your_pc/pages/login.dart';
import 'package:built_your_pc/util/app_color.dart';
import 'package:built_your_pc/util/util.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';
import '../services/auth_provider.dart';
import '../services/pref.dart';

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
  bool _isloading = false;

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
    String fullPath = await supabase.storage.from('profile/profile').upload(
          "${DateTime.now().millisecondsSinceEpoch}.jpg",
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
      backgroundColor: bg,
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 50, 0, 70),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: bg,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 18,
                        ),
                        CostumText(
                          data: "Registration",
                          size: 20,
                        ),
                        const SizedBox(height: 36),

                        Padding(
                          padding: const EdgeInsets.fromLTRB(18, 8, 18, 8),
                          child: SizedBox(
                            child: TextField(
                              controller: _namaController,
                              decoration: InputDecoration(
                                labelText: 'Name',
                                labelStyle: const TextStyle(
                                    color: Color.fromARGB(255, 58, 58, 58)),
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Color.fromARGB(255, 68, 68, 68),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color:
                                          Color.fromARGB(255, 177, 177, 177)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color:
                                          Color.fromARGB(255, 148, 148, 148)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color:
                                          Color.fromARGB(255, 185, 185, 185)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 235, 234, 234),
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
                                    color: Color.fromARGB(255, 46, 46, 46)),
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: Color.fromARGB(255, 65, 64, 64),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color:
                                          Color.fromARGB(255, 173, 173, 173)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color:
                                          Color.fromARGB(255, 185, 184, 184)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color:
                                          Color.fromARGB(255, 141, 139, 139)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 240, 240, 240),
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
                                    color: Color.fromARGB(255, 63, 63, 63)),
                                prefixIcon: const Icon(
                                  Icons.lock_rounded,
                                  color: Color.fromARGB(255, 82, 81, 81),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color:
                                          Color.fromARGB(255, 160, 159, 159)),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color:
                                          Color.fromARGB(255, 168, 168, 168)),
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
                                    const Color.fromARGB(255, 241, 241, 241),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Foto dalam bentuk lingkaran
                        CircleAvatar(
                          backgroundColor:
                              const Color.fromARGB(255, 226, 226, 226),
                          radius: 60,
                          backgroundImage: _userProfile != null
                              ? FileImage(_userProfile!)
                              : null,
                          child: _userProfile == null
                              ? InkWell(
                                  onTap: () => _pickProductPicture(),
                                  splashFactory: InkSplash.splashFactory,
                                  splashColor: Colors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.add,
                                        size: 40,
                                        color:
                                            Color.fromARGB(255, 148, 148, 148),
                                      ),
                                      const Text(
                                        'Upload Foto',
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 116, 116, 116),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : null,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                  fixedSize: WidgetStateProperty.all(
                                      const Size(240, 42)),
                                  padding: WidgetStateProperty.all(
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0)),
                                  backgroundColor:
                                      WidgetStateProperty.all(buttonColor),
                                  elevation: WidgetStateProperty.all(2),
                                ),
                                onPressed: () async {
                                  setState(() {
                                    _isloading = true;
                                  });
                                  final user = await _register();
                                  if (user != null && mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: const Duration(seconds: 1),
                                        backgroundColor: const Color.fromARGB(
                                            255, 242, 255, 242),
                                        content: Text(
                                          'Registrasi Berhasil! Silakan Login..',
                                          style: const TextStyle(
                                              fontFamily: 'Poppins-regular',
                                              fontSize: 14,
                                              color: Color.fromARGB(
                                                  255, 61, 223, 83)),
                                        ),
                                      ),
                                    );
                                    await supabase.auth.signOut();
                                    await PrefService().clearSession();
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPage()));
                                  }
                                },
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                      fontFamily: 'Poppins-regular',
                                      fontSize: 15,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                ),
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                  fixedSize: WidgetStateProperty.all(
                                      const Size(150, 42)),
                                  padding: WidgetStateProperty.all(
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0)),
                                  backgroundColor: WidgetStateProperty.all(bg),
                                  elevation: WidgetStateProperty.all(0),
                                ),
                                onPressed: () async {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()));
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontFamily: 'Poppins-Regular',
                                    fontSize: 15,
                                    color: Color.fromARGB(255, 48, 48, 48),
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
