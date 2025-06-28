// import 'package:connectfeso/screens/360_screen.dart';
// import 'package:connectfeso/screens/teste.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_speed_dial/flutter_speed_dial.dart'; // Importa SpeedDial
// import '../services/auth_service.dart';
// import 'login_screen.dart';
// import 'ar_screen.dart'; // Tela de Realidade Aumentada
// import 'chat_screen.dart'; // Tela do Chatbot de IA
// import 'package:carousel_slider/carousel_slider.dart';
//
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   // _HomeScreenState createState() => _HomeScreenState();
//   State<HomeScreen> createState() => _HomeScreenState();
//
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final AuthService _authService = AuthService();
//   late GoogleMapController _mapController; // controlador de mapa
//
//   Set<Marker> markers = {}; // criar 1 ou mais marcadores no mapa
//   double lat = -22.433915;
//   double long = -42.979152;
//
//   // Coordenadas dos locais
//   final List<LatLng> locations = [
//     LatLng(-22.433915, -42.979152), // Campus Sede
//     LatLng(-22.393867, -42.959523), // Campus Quinta do Paraíso
//     LatLng(-22.440599, -42.978091), // Centro Cultural Feso Pró-Arte
//   ];
//
//   final List<String> locationNames = [
//     "Campus Antonio Paulo Capanema de Souza",
//     "Campus Quinta do Paraíso",
//     "Centro Cultural Feso Pró-Arte",
//   ];
//
//   final List<Map<String, String>> locais = [
//     {
//       'titulo': 'Campus Antonio Paulo Capanema de Souza',
//       'path': 'assets/foto_sede.jpg'
//     },
//     {
//       'titulo': 'Campus Quinta do Paraíso',
//       'path': 'assets/foto_fazenda.jpg'
//     },
//     {
//       'titulo': 'Centro Cultural Feso Pro Arte',
//       'path': 'assets/foto_proarte.jpg'
//     },
//   ];
//
//
//   void _onMapCreated(GoogleMapController controller) {
//     _mapController = controller;
//
//     // Cria os marcadores para cada local
//     for (int i = 0; i < locations.length; i++) {
//       final Marker marker = Marker(
//         markerId: MarkerId('marker_$i'),
//         position: locations[i],
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//         infoWindow: InfoWindow(
//           title: locationNames[i],
//           snippet: "Clique para ver o tour 360º",
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => TourScreen()),
//             );
//           },
//         ),
//       );
//
//       // Adiciona o marcador ao conjunto
//       markers.add(marker);
//     }
//
//     // Atualiza a UI
//     setState(() {});
//   }
//
//
//   void _moveToLocation(LatLng position) {
//     _mapController.animateCamera(CameraUpdate.newLatLng(position));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xF5F5F5F5),
//       appBar: AppBar(
//         automaticallyImplyLeading: false, // esconde a seta de retorno do appbar
//         backgroundColor: Color(0xFF006B64),
//         title: Image.asset(
//           "assets/connect_feso_branco.png",
//           height: 50, // Ajuste o tamanho conforme necessário
//         ),
//         iconTheme: IconThemeData(color: Colors.white),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.exit_to_app, color: Colors.white, size: 30),
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
//
//           //ajuste do mapa
//           Container(
//             height: MediaQuery.of(context).size.height / 2.5, // tamanho do mapa,
//             child: GoogleMap(
//               onMapCreated: _onMapCreated,
//               initialCameraPosition: CameraPosition(
//                 target: LatLng(lat, long),
//                 zoom: 17.5,
//               ),
//               markers: markers,
//             ),
//           ),
//
//           // marcadores
//           Expanded(
//             child: ListView.builder(
//               itemCount: locationNames.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   leading: Image.asset(
//                     "assets/marcador.png", // Caminho da imagem no assets
//                     width: 40,
//                     height: 40,
//                   ),
//                   title: Text(locationNames[index]),
//                   onTap: () {
//                     // Move a câmera até o local selecionado
//                     _moveToLocation(locations[index]);
//
//                     // Mostra o balão do marcador (InfoWindow)
//                     Future.delayed(Duration(milliseconds: 300), () {
//                       _mapController.showMarkerInfoWindow(MarkerId('marker_$index'));
//                     });
//                   },
//                 );
//               },
//             ),
//           ),
//
//         ],
//       ),
//
//
//       // MENU FLUTUANTE EXPANSÍVEL
//       floatingActionButton: _buildSpeedDial(),
//     );
//   }
//
//
//   // Método para criar o menu flutuante com SpeedDial
//   Widget _buildSpeedDial() {
//     return SpeedDial(
//       animatedIcon: AnimatedIcons.menu_close,
//       animatedIconTheme: IconThemeData(color: Colors.white, size: 30),
//       backgroundColor: Color(0xFF006B64),
//       foregroundColor: Colors.white,
//       closeManually: false, // Garante que o botão fecha sozinho
//       children: [
//
//         //botão de realidade aumentada
//         SpeedDialChild(
//           child: Icon(Icons.view_in_ar, color: Colors.white),
//           backgroundColor: Color(0xFF006B64),
//           // label: "Realidade Aumentada",
//           label: "Menu Teste",
//           labelStyle: TextStyle(fontSize: 14, color: Colors.white),
//           labelBackgroundColor: Color(0xFF006B64),
//           onTap: () {
//             Navigator.push(
//               context,
//               // MaterialPageRoute(builder: (context) => ARScreen()),
//               MaterialPageRoute(builder: (context) => MenuTeste()),
//             );
//           },
//         ),
//
//         // botão de chatbot com IA
//         SpeedDialChild(
//           child: Icon(Icons.chat, color: Colors.white),
//           backgroundColor: Color(0xFF006B64),
//           label: "Connect Chat",
//           labelStyle: TextStyle(fontSize: 14, color: Colors.white), // Texto branco
//           labelBackgroundColor: Color(0xFF006B64), // Fundo da label
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => ChatScreen()),
//             );
//           },
//         ),
//
//         // botão do Tour 360
//         SpeedDialChild(
//           child: Image.asset(
//             // 'assets/icone_360.png',
//             'assets/360-graus.png',
//             width: 30,
//             height: 30,
//             color: Colors.white, // opcional: aplica uma cor à imagem (funciona com locais monocromáticas)
//           ),
//           backgroundColor: Color(0xFF006B64),
//           label: "Tour 360º",
//           labelStyle: TextStyle(fontSize: 14, color: Colors.white),
//           labelBackgroundColor: Color(0xFF006B64),
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => TourScreen()),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../services/auth_service.dart';
import 'login_screen.dart';
import 'chat_screen.dart';
import 'ar_screen.dart';
import '360_screen.dart';
import 'teste.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();
  late GoogleMapController _mapController;

  final List<Map<String, dynamic>> locais = [
    {
      'campusId': '1',
      'titulo': 'Campus Antonio Paulo Capanema de Souza',
      'imagem': 'assets/foto_sede.jpg',
      'posicao': LatLng(-22.433915, -42.979152),
    },
    {
      'campusId': '2',
      'titulo': 'Campus Quinta do Paraíso',
      'imagem': 'assets/foto_fazenda.jpg',
      'posicao': LatLng(-22.393867, -42.959523),
    },
    {
      'campusId': '3',
      'titulo': 'Centro Cultural Feso Pro Arte',
      'imagem': 'assets/foto_proarte.jpg',
      'posicao': LatLng(-22.440599, -42.978091),
    },
  ];

  int _currentIndex = 0;
  Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _atualizarMapa();
  }

  void _atualizarMapa() {
    final local = locais[_currentIndex];

    _mapController.animateCamera(
      CameraUpdate.newLatLng(local['posicao']),
    );

    setState(() {
      _markers = {
        Marker(
          markerId: MarkerId("local"),
          position: local['posicao'],
          infoWindow: InfoWindow(
            title: local['titulo'],
            snippet: "Clique para ver o tour 360º",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TourScreen(campusId: locais[_currentIndex]['campusId']),
                ),
              );
            },
          ),
        ),
      };
    });

    Future.delayed(Duration(milliseconds: 500), () {
      _mapController.showMarkerInfoWindow(MarkerId("local"));
    });
  }

  void _onCarouselChanged(int index, CarouselPageChangedReason reason) {
    setState(() {
      _currentIndex = index;
    });
    _atualizarMapa();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF006B64),
        title: Image.asset("assets/connect_feso_branco.png", height: 50),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.white, size: 30),
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
          // MAPA
          Container(
            height: MediaQuery.of(context).size.height * 0.56,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: locais[0]['posicao'],
                zoom: 17.5,
              ),
              markers: _markers,
            ),
          ),

          // CARROSSEL PRINCIPAL
          SizedBox(
            height: 220, // Ajuste esse valor para subir ou descer
            child: CarouselSlider.builder(
              itemCount: locais.length,
              itemBuilder: (context, index, realIdx) {
                final local = locais[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      local['titulo'],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        local['imagem'],
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              },
              options: CarouselOptions(
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 15),
                onPageChanged: _onCarouselChanged,
              ),
            ),
          )

        ],
      ),
      floatingActionButton: _buildSpeedDial(),
    );
  }

  // Método para criar o menu flutuante com SpeedDial
  Widget _buildSpeedDial() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(color: Colors.white, size: 30),
      backgroundColor: Color(0xFF006B64),
      foregroundColor: Colors.white,
      closeManually: false, // Garante que o botão fecha sozinho
      children: [

        //botão de realidade aumentada
        SpeedDialChild(
          child: Icon(Icons.view_in_ar, color: Colors.white),
          backgroundColor: Color(0xFF006B64),
          label: "Realidade Aumentada",
          // label: "Menu Teste",
          labelStyle: TextStyle(fontSize: 14, color: Colors.white),
          labelBackgroundColor: Color(0xFF006B64),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ARScreen()),
              // MaterialPageRoute(builder: (context) => MenuTeste()),
            );
          },
        ),

        // botão de chatbot com IA
        SpeedDialChild(
          child: Icon(Icons.chat, color: Colors.white),
          backgroundColor: Color(0xFF006B64),
          label: "Connect Chat",
          labelStyle: TextStyle(fontSize: 14, color: Colors.white), // Texto branco
          labelBackgroundColor: Color(0xFF006B64), // Fundo da label
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatScreen()),
            );
          },
        ),

        // botão do Tour 360
        // SpeedDialChild(
        //   child: Image.asset(
        //     // 'assets/icone_360.png',
        //     'assets/360-graus.png',
        //     width: 30,
        //     height: 30,
        //     color: Colors.white, // opcional: aplica uma cor à imagem (funciona com locais monocromáticas)
        //   ),
        //   backgroundColor: Color(0xFF006B64),
        //   label: "Tour 360º",
        //   labelStyle: TextStyle(fontSize: 14, color: Colors.white),
        //   labelBackgroundColor: Color(0xFF006B64),
        //   onTap: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => TourScreen()),
        //     );
        //   },
        // ),
      ],
    );
  }
}

