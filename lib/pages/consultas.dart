import 'package:app_ye_gestao_de_saude/models/consultas_model.dart';
import 'package:app_ye_gestao_de_saude/pages/data_consultas.dart';
import 'package:app_ye_gestao_de_saude/pages/nova_consulta.dart';
import 'package:app_ye_gestao_de_saude/services/consultas_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Consultas extends StatefulWidget {
  const Consultas({super.key});

  @override
  State<Consultas> createState() => _ConsultasState();
}

class _ConsultasState extends State<Consultas> {
  final ConsultasService dbService = ConsultasService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 246, 241),

      body: Stack(
        children: [
          StreamBuilder<List<ModeloConsultas>>(
              stream: dbService.getConsultas(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var consultas = snapshot.data!;
                var groupedConsultas =
                    _groupConsultasPorEspecialidade(consultas);

                return ListView.builder(
                    itemCount: groupedConsultas.keys.length,
                    itemBuilder: (context, index) {
                      var especialidade =
                          groupedConsultas.keys.elementAt(index);

                      var consultasPorEspecialidade =
                          groupedConsultas[especialidade]!;

                      return ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DataConsultas(
                                    especialidade: especialidade,
                                      consultas: consultasPorEspecialidade)));
                        },
                        title: Row(
                          children: [
                            Text(
                              '${especialidade}',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            Spacer(),
                            Icon(Icons.info_outline),
                          ],
                        ),
                      );
                    });
              }),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NovaConsulta()),
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

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => NovaConsulta()));
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }

  Map<String, List<ModeloConsultas>> _groupConsultasPorEspecialidade(
      List<ModeloConsultas> consultas) {
    Map<String, List<ModeloConsultas>> groupedConsultas = {};
    for (var consulta in consultas) {
      if (!groupedConsultas.containsKey(consulta.especialidade)) {
        groupedConsultas[consulta.especialidade] = [];
      }
      groupedConsultas[consulta.especialidade]!.add(consulta);
    }
    return groupedConsultas;
  }
}
