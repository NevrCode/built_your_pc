import 'package:built_your_pc/pages/admin/admin.dart';
import 'package:built_your_pc/pages/admin/admin_catalog.dart';
import 'package:built_your_pc/pages/login.dart';
import 'package:built_your_pc/pages/register.dart';
import 'package:built_your_pc/pages/user/index.dart';
import 'package:built_your_pc/services/auth_provider.dart';
import 'package:built_your_pc/services/component_provider.dart';
import 'package:built_your_pc/services/order_provider.dart';
import 'package:built_your_pc/services/pc_provider.dart';
import 'package:built_your_pc/services/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51QRpopAuTZ1Aldd1TX11gUvIZetpikDCCR5qlDdc6YoaVkVHYcwNFVdEwfGYAS3czbCruQbOm79Ta7TlXofi6wyJ00Fvxj6q0y"; // Replace with your Stripe publishable key
  Stripe.merchantIdentifier = 'HeavyHub';
  await Stripe.instance.applySettings();
  await Supabase.initialize(
    url: 'https://rjkgsarcxukfiomccvrq.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJqa2dzYXJjeHVrZmlvbWNjdnJxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzAzNjA2MTUsImV4cCI6MjA0NTkzNjYxNX0.JKhPixe_tSBv4uQ4O_Wlrhbts0nN_EqPWgqFgXxiaok',
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ComponentProvider()),
        ChangeNotifierProvider(create: (context) => PCProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
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
      home: LoginPage(),
    );
  }
}
