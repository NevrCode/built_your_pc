import 'package:built_your_pc/pages/admin/admin.dart';
import 'package:built_your_pc/pages/admin/admin_catalog.dart';
import 'package:built_your_pc/pages/login.dart';
import 'package:built_your_pc/pages/register.dart';
import 'package:built_your_pc/pages/user/index.dart';
import 'package:built_your_pc/services/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://rjkgsarcxukfiomccvrq.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJqa2dzYXJjeHVrZmlvbWNjdnJxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzAzNjA2MTUsImV4cCI6MjA0NTkzNjYxNX0.JKhPixe_tSBv4uQ4O_Wlrhbts0nN_EqPWgqFgXxiaok',
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.light(),
      routes: {
        '/': (context) => const IndexPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/forgot': (context) => const Placeholder(),
        '/admin': (context) => const AdminHomePage(),
        '/adminKatalog': (context) => const AdminCatalogPage(),
      },
      initialRoute: '/admin',
    );
  }
}
