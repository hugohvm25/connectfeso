import 'package:flutter/material.dart';

class TourScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tour 360º")),
      body: Center(child: Text("Aqui será exibido o modelo 360º do local")),
    );
  }
}
