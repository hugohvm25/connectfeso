// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../services/auth_service.dart';
// import 'login_screen.dart';
// import 'ar_screen.dart';
//
//
// class HomeScreen extends StatelessWidget {
//   final AuthService _authService = AuthService();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Connect Feso"),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.exit_to_app),
//             onPressed: () async {
//               // Realiza o logout
//               await _authService.signOut();
//               // Exibe uma mensagem de sucesso ao deslogar
//               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                 content: Text("Desconectado com sucesso!"),
//                 duration: Duration(seconds: 2),
//                 )
//               );
//               // Navega de volta para a tela de login
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => LoginScreen()),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             // Navega para a tela de AR
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => ARScreen()),
//             );
//           },
//           child: Text("Explorar com Realidade Aumentada"),
//         ),
//       ),
//     );
//   }
// }


//
//
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../services/auth_service.dart';
// import 'login_screen.dart';
// import 'ar_screen.dart';
//
// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final AuthService _authService = AuthService();
//   GoogleMapController? _mapController; // Alterado para "?" para evitar erro antes da inicialização
//   bool _isMapLoaded = false; // Variável para verificar se o mapa foi carregado
//
//   // Coordenadas do local desejado
//   final LatLng _location = LatLng(-22.433798, -42.979064);
//
//   // Método chamado quando o mapa for criado
//   void _onMapCreated(GoogleMapController controller) {
//     setState(() {
//       _mapController = controller;
//       _isMapLoaded = true; // Define que o mapa foi carregado
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFF006B64), // Cor do fundo do AppBar
//         title: Text(
//           "Connect Feso",
//           style: TextStyle(color: Colors.white), // Deixa o texto branco
//         ),
//         iconTheme: IconThemeData(color: Colors.white), // Deixa os ícones brancos
//         actions: [
//           IconButton(
//             icon: Icon(Icons.exit_to_app, color: Colors.white), // Ícone branco
//             onPressed: () async {
//               await _authService.signOut();
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text("Desconectado com sucesso!")),
//               );
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => LoginScreen()),
//               );
//             },
//           ),
//         ],
//       ),
//
//       body: Column(
//         children: [
//           // Define um tamanho menor para o Google Maps
//           Container(
//             height: 300, // Ajuste a altura do mapa conforme necessário
//             child: _isMapLoaded // Se o mapa foi carregado, exibe o mapa
//                 ? GoogleMap(
//               onMapCreated: _onMapCreated,
//               initialCameraPosition: CameraPosition(
//                 target: _location,
//                 zoom: 15, // Nível de zoom inicial
//               ),
//               markers: {
//                 Marker(
//                   markerId: MarkerId("local"),
//                   position: _location,
//                   infoWindow: InfoWindow(title: "Local Desejado"),
//                 ),
//               },
//             )
//                 : Center(child: CircularProgressIndicator()), // Mostra um carregamento enquanto o mapa não é inicializado
//           ),
//           SizedBox(height: 20),
//
//           // Adiciona mais informações abaixo do mapa
//           Padding(
//             padding: EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 Text(
//                   "Explore este local no mapa e veja em realidade aumentada!",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: 10),
//
//                 // Botão de realidade aumentada
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => ARScreen()),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Color(0xFF006B64), // Cor do botão
//                     foregroundColor: Colors.white, // Cor do texto do botão
//                     padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
//                     textStyle: TextStyle(fontSize: 18),
//                   ),
//                   child: Text("Explorar com Realidade Aumentada"),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart'; // Importa SpeedDial
import '../services/auth_service.dart';
import 'login_screen.dart';
import 'ar_screen.dart'; // Tela de Realidade Aumentada
import 'chat_screen.dart'; // Tela do Chatbot de IA

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();
  GoogleMapController? _mapController;
  bool _isMapLoaded = false;

  final LatLng _location = LatLng(-22.433798, -42.979064);

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _mapController = controller;
      _isMapLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF006B64),
        title: Text("Connect Feso", style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () async {
              await _authService.signOut();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Desconectado com sucesso!")),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),

      body: Column(
        children: [
          Container(
            height: 300,
            child: _isMapLoaded
                ? GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _location,
                zoom: 15,
              ),
              markers: {
                Marker(
                  markerId: MarkerId("local"),
                  position: _location,
                  infoWindow: InfoWindow(title: "Local Desejado"),
                ),
              },
            )
                : Center(child: CircularProgressIndicator()),
          ),
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  "Explore este local no mapa e veja em realidade aumentada!",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),

      // MENU FLUTUANTE EXPANSÍVEL
      floatingActionButton: _buildSpeedDial(),
    );
  }

  // Método para criar o menu flutuante com SpeedDial
  Widget _buildSpeedDial() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close, // Ícone animado de abrir/fechar
      backgroundColor: Color(0xFF006B64), // Cor do botão principal
      children: [
        // Botão para Realidade Aumentada
        SpeedDialChild(
          child: Icon(Icons.view_in_ar, color: Colors.white),
          backgroundColor: Color(0xFF006B64),
          label: "Realidade Aumentada",
          labelStyle: TextStyle(fontSize: 14),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ARScreen()),
            );
          },
        ),

        // Botão para Chatbot de IA
        SpeedDialChild(
          child: Icon(Icons.chat, color: Colors.white),
          backgroundColor: Color(0xFF006B64),
          label: "Chatbot de IA",
          labelStyle: TextStyle(fontSize: 14),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatScreen()),
            );
          },
        ),
      ],
    );
  }
}



        // @@@@@ MODELO DE BOTÃO PARA O MENU

        // Visibility(
        //   visible: false, // Pode ser alterado caso precise ocultar
        //   child: FloatingActionButton(
        //     heroTag: "btn_ar",
        //     backgroundColor: Color(0xFF006B64),
        //     onPressed: () {
        //       Navigator.push(
        //         context,
        //         MaterialPageRoute(builder: (context) => DirecionamentoDeTela()), //Adicionar também no import
        //       );
        //     },
        //     child: Icon(Icons.view_in_ar, color: Colors.white),
        //   ),
        // ),
        // SizedBox(height: 10),








