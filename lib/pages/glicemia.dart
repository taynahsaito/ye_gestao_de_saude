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
                  'Glicemia',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(220, 105, 126, 80),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<List<ModeloGlicemia>>(
                stream: _glicemiaService.getGlicemias(),
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
                      final glicemia = glicemias[index];
                      return ListTile(
                        title: Text('Glicemia: ${glicemia.glicemia} mg/dL'),
                        subtitle: Text(
                            'Data: ${DateFormat('dd/MM/yyyy').format(glicemia.dataAfericao)}'),
                      );
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
