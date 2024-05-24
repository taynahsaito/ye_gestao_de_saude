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
          StreamBuilder(
              stream: dbService.consultasCollection.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var consultas = snapshot.data!.docs
                    .map((doc) => ModeloConsultas.fromFirestore(doc))
                    .toList();

                return ListView.builder(
                    itemCount: consultas.length,
                    itemBuilder: (context, index) {
                      var consulta = consultas[index];
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DataConsultas(
                                      modeloConsultas: consulta)));
                        },
                        title: Row(
                          children: [
                            Text(
                              '${consulta.especialidade}',
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
}
