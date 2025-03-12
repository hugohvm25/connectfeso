import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';
import 'ar_screen.dart';

class HomeScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Turismo Virtual"),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              // Realiza o logout
              await _authService.signOut();
              // Exibe uma mensagem de sucesso ao deslogar
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text("Desconectado com sucesso!"),
                duration: Duration(seconds: 2),
              ));
              // Navega de volta para a tela de login
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navega para a tela de AR
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ARScreen()),
            );
          },
          child: Text("Explorar com Realidade Aumentada"),
        ),
      ),
    );
  }
}
