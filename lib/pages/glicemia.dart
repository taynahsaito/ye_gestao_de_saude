import 'package:app_ye_gestao_de_saude/models/glicemia_model.dart';
import 'package:app_ye_gestao_de_saude/pages/nova_glicemia.dart';
import 'package:app_ye_gestao_de_saude/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:app_ye_gestao_de_saude/services/glicemia_service.dart';
import 'package:intl/intl.dart';

class Glicemia extends StatelessWidget {
  final GlicemiaService _glicemiaService = GlicemiaService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 245, 246, 241),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(220, 105, 126, 80), // Define a cor do ícone
        ),
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NavBar(selectedIndex: 0),
                ),
              );
            },
          ),
        ),
      ),
      body: Stack(children: [
        Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 90, 20, 30),
              child: Center(
                child: Text(
                  'Histórico de glicemia',
                  style: TextStyle(
                    fontSize: 22,
                    color: Color.fromARGB(220, 105, 126, 80),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<List<ModeloGlicemia>>(
                stream: _glicemiaService.getGlicemia(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('Nenhuma glicemia registrada.'));
                  }

                  final glicemias = snapshot.data!;
                  return ListView.builder(
                    itemCount: glicemias.length,
                    itemBuilder: (context, index) {
                      var glicemia = glicemias[index];
                      return ListTile(
                          title: Container(
                        padding: const EdgeInsets.fromLTRB(25, 20, 25, 20),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(150, 203, 230, 176),
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            Text(
                              '${glicemia.dataAfericao}',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(), // Este Spacer vai empurrar o próximo widget para a direita
                            Text(
                              '${glicemia.glicemia}',
                              style: const TextStyle(
                                color: Color.fromARGB(255, 78, 101, 61),
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ));
                    },
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NovaGlicemia()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(
                        50, 105, 126, 80), // Cor de fundo do botão
                    foregroundColor: Colors.white,
                    shape: const CircleBorder(),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.add),
                  ),
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
