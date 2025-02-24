import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Checar se o usuário está logado
  User? user = FirebaseAuth.instance.currentUser;

  runApp(MyApp(user: user)); // Passando o estado de autenticação
}

class MyApp extends StatelessWidget {
  final User? user; // Recebe o usuário autenticado

  const MyApp({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Connect Feso',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: user != null ? HomeScreen() : LoginScreen(), // Redireciona conforme o estado do usuário
    );
  }
}
