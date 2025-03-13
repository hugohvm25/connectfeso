import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPassScreen extends StatefulWidget {
  @override
  _ResetPassScreenState createState() => _ResetPassScreenState();
}

class _ResetPassScreenState extends State<ResetPassScreen> {
  final TextEditingController _emailController = TextEditingController();

  Future<void> _resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
      _showAlertDialog("E-mail de redefinição enviado! Verifique sua caixa de entrada.");
    } on FirebaseAuthException catch (e) {
      // String errorMessage = "Erro ao redefinir senha";
      _showAlertDialog('Erro ao redefinir senha');
      // _showAlertDialog('Erro ao redefinir senha $e'); // mostra o erro
      if (e.code == 'invalid-email') {
        _showAlertDialog('E-mail inválido');
      }
    }
  }

  void _showAlertDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Alerta"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Fechar"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(245, 245, 245, 245), // Quase branco
      body: Column(
        children: [
          // Botão de voltar no topo, como uma AppBar
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10), // Ajuste do espaçamento
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Color(0xFF006B64), size: 28),
                  onPressed: () {
                    Navigator.pop(context); // Voltar para a tela anterior
                  },
                ),
              ),
            ),
          ),

          // Corpo da tela
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    'assets/resetsenha.png',
                    height: 100,
                  ),
                  SizedBox(height: 30),

                  Text(
                    "Digite seu e-mail e enviaremos um link para redefinir sua senha:",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Color(0xFF006B64)),
                  ),
                  SizedBox(height: 20),

                  _buildTextField("E-mail", _emailController),
                  SizedBox(height: 10),

                  _buildLoginButton("Enviar Link de Redefinição", _resetPassword),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }




}

Widget _buildLoginButton(String text, VoidCallback onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF006B64),
      minimumSize: Size(double.infinity, 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 16, color: Colors.white),
    ),
  );
}

// caixa de texto
Widget _buildTextField(String hint, TextEditingController controller) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
    ),
  );
}
