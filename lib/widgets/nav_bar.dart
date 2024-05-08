import 'package:app_ye_gestao_de_saude/pages/consultas.dart';
import 'package:app_ye_gestao_de_saude/pages/exames.dart';
import 'package:app_ye_gestao_de_saude/pages/home_page.dart';
import 'package:app_ye_gestao_de_saude/pages/medicamentos.dart';
import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key});

  @override
  State<NavBar> createState() => _NavBar();
}

class _NavBar extends State<NavBar> {
  int selectedIndex = 0;
  static const List<Widget> pages = <Widget>[
    HomePage(),
    Exames(),
    Consultas(),
    Medicamentos(),
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
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
              size: 25,
              AssetImage(
                  'lib/assets/icone_exames.png'), // Substitua pelo caminho da imagem
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

    // return Scaffold(
    //   backgroundColor: const Color.fromARGB(255, 245, 246, 241),
    //   body: Center(
    //     child: pages.elementAt(selectedIndex),
    //   ),
    //   bottomNavigationBar: BottomNavigationBar(
    //     currentIndex: selectedIndex,
    //     onTap: (int index) {
    //       setState(() {
    //         selectedIndex = index;
    //       });
    //     },
    //     items: const [
    //       BottomNavigationBarItem(
    //         icon: ImageIcon(
    //           AssetImage(
    //               'lib/assets/icone_homepage.png'), // Substitua pelo caminho da imagem
    //         ),
    //         label: 'Início',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: ImageIcon(
    //           AssetImage(
    //               'lib/assets/icone_exames.png'), // Substitua pelo caminho da imagem
    //         ),
    //         label: 'Exames',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: ImageIcon(
    //           AssetImage(
    //               'lib/assets/icone_consultas.png'), // Substitua pelo caminho da imagem
    //         ),
    //         label: 'Consultas',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: ImageIcon(
    //           AssetImage(
    //             'lib/assets/icone_medicamentos.png',
    //           ), // Substitua pelo caminho da imagem
    //         ),
    //         label: 'Medicamentos',
    //       ),
    //     ],
    //     backgroundColor: Colors.white,
    //     selectedItemColor: const Color.fromARGB(180, 14, 14, 109),
    //     unselectedItemColor: Colors.grey,
    //     showSelectedLabels: true,
    //     selectedFontSize: 12,
    //     unselectedFontSize: 12,
    //     type: BottomNavigationBarType.fixed,
    //   ),
    // );
  }
}
