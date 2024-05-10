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

  @override
  Widget build(BuildContext context) {
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
        destinations: <NavigationDestination>[
          NavigationDestination(
            icon: ImageIcon(
              const AssetImage(
                'lib/assets/icone_homepage.png',
              ),
              color: selectedIndex == 0
                  ? const Color.fromARGB(255, 74, 83, 62)
                  : const Color.fromARGB(
                      137, 88, 100, 73), // Cor do ícone selecionado
              size: 25,
            ),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: ImageIcon(
              const AssetImage('lib/assets/icon_exames.png'),
              color: selectedIndex == 1
                  ? const Color.fromARGB(255, 74, 83, 62)
                  : const Color.fromARGB(
                      137, 88, 100, 73), // Cor do ícone selecionado
              size: 34,
            ),
            label: 'Exames',
          ),
          NavigationDestination(
            icon: ImageIcon(
              const AssetImage('lib/assets/icone_consultas.png'),
              color: selectedIndex == 2
                  ? const Color.fromARGB(255, 74, 83, 62)
                  : const Color.fromARGB(
                      137, 88, 100, 73), // Cor do ícone selecionado
              size: 25,
            ),
            label: 'Consultas',
          ),
          NavigationDestination(
            icon: ImageIcon(
              const AssetImage('lib/assets/icone_medicamentos.png'),
              color: selectedIndex == 3
                  ? const Color.fromARGB(255, 74, 83, 62)
                  : const Color.fromARGB(
                      137, 88, 100, 73), // Cor do ícone selecionado
              size: 25,
            ),
            label: 'Medicamentos',
          ),
        ],
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: const [
          HomePage(),
          Exames(),
          Consultas(),
          Medicamentos(),
        ],
      ),
    );
  }
}
