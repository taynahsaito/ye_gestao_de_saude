import 'package:app_ye_gestao_de_saude/models/medicamentos_model.dart';
import 'package:app_ye_gestao_de_saude/pages/consultas.dart';
import 'package:app_ye_gestao_de_saude/pages/exames.dart';
import 'package:app_ye_gestao_de_saude/pages/home_page.dart';
import 'package:app_ye_gestao_de_saude/pages/medicamentos.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  final int selectedIndex;
  const NavBar({Key? key, required this.selectedIndex});

  @override
  State<NavBar> createState() => _NavBar();
}

class _NavBar extends State<NavBar> {
//   final ModeloMedicamentos medicamentos = ModeloMedicamentos(id: '', nome: '', horario: '', intervaloHoras: '', periodoTomado: ''

// );
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  static List<Widget> pages = <Widget>[
    const HomePage(),
    const Exames(),
    const Consultas(),
    const Medicamentos(),
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        onDestinationSelected: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
        indicatorColor: const Color.fromARGB(180, 223, 223, 223),
        indicatorShape: const CircleBorder(),
        selectedIndex: selectedIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: ImageIcon(
              size: 25,
              AssetImage(
                'lib/assets/icone_homepage.png',
              ), // Substitua pelo caminho da imagem
            ),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: ImageIcon(
              size: 28,
              AssetImage(
                  'lib/assets/icon_exames.png'), // Substitua pelo caminho da imagem
            ),
            label: 'Exames',
          ),
          NavigationDestination(
            icon: ImageIcon(
              size: 25,
              AssetImage(
                  'lib/assets/icone_consultas.png'), // Substitua pelo caminho da imagem
            ),
            label: 'Consultas',
          ),
          NavigationDestination(
            icon: ImageIcon(
              size: 25,
              AssetImage(
                  'lib/assets/icone_medicamentos.png'), // Substitua pelo caminho da imagem
            ),
            label: 'Medicamentos',
          ),
        ],
      ),
      body: <Widget>[
        const HomePage(),
        const Exames(),
        const Consultas(),
        const Medicamentos()
      ][selectedIndex],
    );

    //OPÇÃO DE NAVBAR QUE QUANDO CLICA, APARECE UM FUNDO ESCURO ATRAS
// import 'package:flutter/material.dart';
// import 'package:app_ye_gestao_de_saude/pages/consultas.dart';
// import 'package:app_ye_gestao_de_saude/pages/exames.dart';
// import 'package:app_ye_gestao_de_saude/pages/home_page.dart';
// import 'package:app_ye_gestao_de_saude/pages/medicamentos.dart';
// class NavBar extends StatefulWidget {
//   const NavBar({Key? key});

//   @override
//   State<NavBar> createState() => _NavBarState();
// }

// class _NavBarState extends State<NavBar> {
//   int _selectedIndex = 0;

//   static const List<Widget> _widgetOptions = <Widget>[
//     HomePage(),
//     Exames(),
//     Consultas(),
//     Medicamentos(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _widgetOptions.elementAt(_selectedIndex),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: ImageIcon(
//               AssetImage(
//                 'lib/assets/icone_homepage.png',
//               ),
//               size: 25,
//             ),
//             label: 'Inicio',
//           ),
//           BottomNavigationBarItem(
//             icon: ImageIcon(
//               AssetImage('lib/assets/icon_exames.png'),
//               size: 28,
//             ),
//             label: 'Exames',
//           ),
//           BottomNavigationBarItem(
//             icon: ImageIcon(
//               AssetImage('lib/assets/icone_consultas.png'),
//               size: 25,
//             ),
//             label: 'Consultas',
//           ),
//           BottomNavigationBarItem(
//             icon: ImageIcon(
//               AssetImage('lib/assets/icone_medicamentos.png'),
//               size: 25,
//             ),
//             label: 'Medicamentos',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: const Color.fromARGB(255, 74, 83, 62),
//         unselectedItemColor: const Color.fromARGB(137, 88, 100, 73),
//         onTap: _onItemTapped,
//         showUnselectedLabels:
//             true, // Exibe as palavras quando não estiverem selecionadas
//         selectedFontSize: 12,
//         unselectedFontSize: 12,
//         type: BottomNavigationBarType.shifting,
//       ),
//     );
//   }
// }
  }
}
