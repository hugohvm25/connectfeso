import 'package:flutter/material.dart';

class ARScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Realidade Aumentada")),
      body: Center(child: Text("Aqui será exibido o modelo 3D do local")),
    );
  }
}
