import 'package:app_ye_gestao_de_saude/models/consultas_model.dart';
import 'package:app_ye_gestao_de_saude/pages/consultas.dart';
import 'package:app_ye_gestao_de_saude/pages/info_consultas.dart';
import 'package:app_ye_gestao_de_saude/pages/informacoes_consultas.dart';
import 'package:app_ye_gestao_de_saude/pages/nova_consulta.dart';
import 'package:app_ye_gestao_de_saude/services/consultas_service.dart';
import 'package:app_ye_gestao_de_saude/widgets/nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DataConsultas extends StatefulWidget {
  final String especialidade;
  final List<ModeloConsultas> consultas;
  const DataConsultas({
    Key? key,
    required this.especialidade,
    required this.consultas,
  }) : super(key: key);

  @override
  _DataConsultasState createState() => _DataConsultasState();
}

class _DataConsultasState extends State<DataConsultas> {
  late List<ModeloConsultas> consultas;

  final ConsultasService dbService = ConsultasService();

  @override
  void initState() {
    super.initState();
    consultas = widget.consultas;
  }

  Future<void> _updateConsultas() async {
    var updatedConsultas =
        await dbService.getConsultasPorEspecialidade(widget.especialidade);
    setState(() {
      consultas = updatedConsultas;
    });
  }

  void _atualizarConsulta() {
    // Função que será chamada após adicionar uma nova consulta
    setState(() {
      // Atualize os dados ou recarregue a tela conforme necessário
    });
  }

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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NavBar(selectedIndex: 2),
                ),
              );
            },
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Center(
                  child: Text(
                    'Consultas realizadas',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(220, 105, 126, 80),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              Text(
                '${widget.especialidade}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(220, 105, 126, 80),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: consultas.length,
                  itemBuilder: (context, index) {
                    var consulta = consultas[index];
                    return ListTile(
                      onTap: () async {
                        bool? result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                InformacoesConsultas(modeloConsultas: consulta),
                          ),
                        );
                        if (result == true) {
                          _updateConsultas();
                        }
                      },
                      title: Row(
                        children: [
                          Text(
                            '${consulta.data}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Spacer(),
                          Icon(Icons.arrow_circle_right_outlined),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
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
                        builder: (context) => NovaConsulta(
                              especialidade: TextEditingController(
                                  text: widget.especialidade),
                              onUpdateConsulta: _atualizarConsulta,
                            )),
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
