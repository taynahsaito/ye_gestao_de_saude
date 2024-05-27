import 'package:app_ye_gestao_de_saude/models/consultas_model.dart';
import 'package:app_ye_gestao_de_saude/pages/data_consultas.dart';
import 'package:app_ye_gestao_de_saude/pages/editar_consultas.dart';
import 'package:app_ye_gestao_de_saude/services/consultas_service.dart';
import 'package:flutter/material.dart';

class InformacoesConsultas extends StatefulWidget {
  final ModeloConsultas modeloConsultas;
  const InformacoesConsultas({super.key, required this.modeloConsultas});

  @override
  State<InformacoesConsultas> createState() => _InformacoesConsultasState();
}

class _InformacoesConsultasState extends State<InformacoesConsultas> {
  //  late ModeloConsultas modeloConsultas;

  ConsultasService consultasService = ConsultasService();
  Future<void> exibirPopUpConfirmacao(
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
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                await consultasService.deletarConsulta(idConsulta);
                Navigator.of(context).pop();
                Navigator.pop(
                    context, true); // Indica que uma consulta foi deletada
              },
              child: Text('Confirmar'),
            ),
          ],
        );
      },
    );
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
                var consultas = [widget.modeloConsultas];
                var groupedConsultas =
                    _groupConsultasPorEspecialidade(consultas);
                var especialidade = groupedConsultas.keys.elementAt(0);
                var consultasPorEspecialidade =
                    groupedConsultas[especialidade]!;
                bool? result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DataConsultas(
                      especialidade: especialidade,
                      consultas: consultasPorEspecialidade,
                    ),
                  ),
                );
                if (result == true) {
                  setState(() {
                    // Atualizar o estado para refletir a mudança na lista de consultas
                  });
                }
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
              // offset: Offset(0, 100), // Posição do menu
              elevation: 8, // Elevação da sombra
              color: const Color.fromARGB(255, 245, 246, 241), // Cor do botão
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0), // Borda arredondada
              ),
              onSelected: (value) async {
                if (value == 'edit') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditarConsultas(
                              consultaId: widget.modeloConsultas.id,
                              especialidade:
                                  widget.modeloConsultas.especialidade,
                              horario: widget.modeloConsultas.horario,
                              resumo: widget.modeloConsultas.resumo,
                            )),
                  );
                } else if (value == 'delete') {
                  await exibirPopUpConfirmacao(
                      context, widget.modeloConsultas.id);
                }
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(60, 20, 60, 100),
            child: Center(
              child: Column(children: [
                const Text(
                  "Consultas realizadas",
                  style: TextStyle(
                    fontSize: 22,
                    // fontFamily: GoogleFonts.poppinsTextTheme,
                    color: Color.fromARGB(220, 105, 126, 80),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  '${widget.modeloConsultas.especialidade}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(220, 105, 126, 80),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Column(
                    children: [
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Data',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 17,
                                color: Color.fromRGBO(119, 138, 96, 1)),
                          )),
                      const SizedBox(
                        height: 5,
                      ),
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
                              '${widget.modeloConsultas.data}',
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Column(
                    children: [
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Horario',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 17,
                                color: Color.fromRGBO(119, 138, 96, 1)),
                          )),
                      const SizedBox(
                        height: 5,
                      ),
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
                              '${widget.modeloConsultas.horario}',
                              style: const TextStyle(
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Column(
                    children: [
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Resumo',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 17,
                                color: Color.fromRGBO(119, 138, 96, 1)),
                          )),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(185, 196, 166, 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: 380,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 12.0),
                          child: SizedBox(
                            child: Center(
                              child: Text(
                                '${widget.modeloConsultas.resumo}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(220, 66, 78, 50),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Column(
                    children: [
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Retorno',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 17,
                                color: Color.fromRGBO(119, 138, 96, 1)),
                          )),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(185, 196, 166, 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        width: 380,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Text(
                              '${widget.modeloConsultas.retorno}',
                              style: const TextStyle(
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Column(
                    children: [
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Lembrete',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 17,
                                color: Color.fromRGBO(119, 138, 96, 1)),
                          )),
                      const SizedBox(
                        height: 5,
                      ),
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
                              '${widget.modeloConsultas.lembrete}',
                              style: const TextStyle(
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
                ),
              ]),
            ),
          ),
        ));
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
