import 'package:app_ye_gestao_de_saude/models/consultas_model.dart';
import 'package:app_ye_gestao_de_saude/pages/data_consultas.dart';
import 'package:app_ye_gestao_de_saude/pages/editar_consultas.dart';
import 'package:app_ye_gestao_de_saude/services/consultas_service.dart';
import 'package:flutter/material.dart';

class InformacoesConsultas extends StatefulWidget {
  final ModeloConsultas modeloConsultas;

  InformacoesConsultas({Key? key, required this.modeloConsultas})
      : super(key: key);

  @override
  _InformacoesConsultasState createState() => _InformacoesConsultasState();
}

class _InformacoesConsultasState extends State<InformacoesConsultas> {
  final ConsultasService consultasService = ConsultasService();
  late ModeloConsultas consultaAtual;

  @override
  void initState() {
    super.initState();
    consultaAtual = widget.modeloConsultas;
  }

  Future<void> _exibirPopUpConfirmacao(
      BuildContext context, String idConsulta) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Deletar consulta'),
          content: Text('Tem certeza de que deseja excluir esta consulta?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar', style: TextStyle(color: Color.fromARGB(220, 105, 126, 80),),),
            ),
            TextButton(
              onPressed: () async {
                await consultasService.deletarConsulta(idConsulta);
                Navigator.of(context).pop();
                Navigator.pop(
                    context, true); // Indica que uma consulta foi deletada
              },
              child: Text('Confirmar', style: TextStyle(color: Color.fromARGB(220, 105, 126, 80),),),
            ),
          ],
        );
      },
    );
  }

  Future<void> _editarConsulta(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditarConsultas(
          modeloConsultas: consultaAtual,
        ),
      ),
    );

    if (result != null && result is ModeloConsultas) {
      setState(() {
        consultaAtual = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 246, 241),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 245, 246, 241),
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(
          color: Color.fromARGB(220, 105, 126, 80), // Define a cor do ícone
        ),
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
        ),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry>[
                const PopupMenuItem(
                  child: Center(
                    child: Text('Editar'),
                  ),
                  value: 'edit',
                ),
                const PopupMenuItem(
                  child: Center(
                    child: Text('Deletar'),
                  ),
                  value: 'delete',
                )
              ];
            },
            icon: const Icon(Icons.more_vert,
                color: Color.fromARGB(220, 105, 126, 80)), // Ícone e cor
            elevation: 8, // Elevação da sombra
            color: const Color.fromARGB(255, 245, 246, 241), // Cor do botão
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0), // Borda arredondada
            ),
            onSelected: (value) async {
              if (value == 'edit') {
                await _editarConsulta(context);
              } else if (value == 'delete') {
                await _exibirPopUpConfirmacao(context, consultaAtual.id);
              }
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(60, 0, 60, 0),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Consultas realizadas",
                  style: TextStyle(
                    fontSize: 22,
                    color: Color.fromARGB(220, 105, 126, 80),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  consultaAtual.especialidade,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(220, 105, 126, 80),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 30),
                _buildInfoField('Data', consultaAtual.data),
                _buildInfoField('Horario', consultaAtual.horario),
                _buildInfoField('Resumo', consultaAtual.resumo),
                _buildInfoField('Retorno', consultaAtual.retorno),
                _buildInfoField('Lembrete', consultaAtual.lembrete),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoField(String title, String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 17,
                color: Color.fromRGBO(119, 138, 96, 1),
              ),
            ),
          ),
          const SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(185, 196, 166, 1),
              borderRadius: BorderRadius.circular(20),
            ),
            width: 380,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Text(
                  info,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(220, 66, 78, 50),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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
