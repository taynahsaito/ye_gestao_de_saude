import 'package:app_ye_gestao_de_saude/models/consultas_model.dart';
import 'package:app_ye_gestao_de_saude/pages/informacoes_consultas.dart';
import 'package:app_ye_gestao_de_saude/pages/nova_consulta.dart';
import 'package:app_ye_gestao_de_saude/services/consultas_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataConsultas extends StatelessWidget {
  final String especialidade;
  final List<ModeloConsultas> consultas;

  DataConsultas(
      {Key? key, required this.consultas, required this.especialidade})
      : super(key: key);

  final ConsultasService dbService = ConsultasService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 246, 241),
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
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: consultas.length,
            itemBuilder: (context, index) {
              var consulta = consultas[index];
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          InformacoesConsultas(modeloConsultas: consulta),
                    ),
                  );
                },
                title: Row(
                  children: [
                    Text(
                      '${consulta.data}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Spacer(),
                    Icon(Icons.arrow_circle_right_outlined),
                  ],
                ),
              );
            },
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
    );
  }
}
