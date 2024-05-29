import 'package:app_ye_gestao_de_saude/models/medicamentos_model.dart';
import 'package:app_ye_gestao_de_saude/pages/editar_medicamento.dart';
import 'package:app_ye_gestao_de_saude/pages/novo_medicamento.dart';
import 'package:app_ye_gestao_de_saude/services/consultas_service.dart';
import 'package:app_ye_gestao_de_saude/services/medicamentos_service.dart';
import 'package:flutter/material.dart';

class Medicamentos extends StatefulWidget {
  final List<ModeloMedicamentos> medicamentos;

  const Medicamentos({super.key, required this.medicamentos});

  @override
  State<Medicamentos> createState() => _MedicamentosState();
}

class _MedicamentosState extends State<Medicamentos> {
  late List<ModeloMedicamentos> medicamentos;
  late ModeloMedicamentos medicamentoAtual;
  final MedicamentosService medicamentosService = MedicamentosService();

  Future<void> _editarConsulta(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditarMedicamento(
          modeloMedicamentos: medicamentoAtual,
        ),
      ),
    );

    if (result != null && result is ModeloMedicamentos) {
      setState(() {
        medicamentoAtual = result;
      });
    }
  }

  Future<void> _exibirPopUpConfirmacao(
      BuildContext context, String idConsulta) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Deletar consulta'),
          content: const  Text('Tem certeza de que deseja excluir esta consulta?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar', style: TextStyle(color: Color.fromARGB(220, 105, 126, 80),),),
            ),
            TextButton(
              onPressed: () async {
                await medicamentosService.deletarMedicamento(idConsulta);
                Navigator.of(context).pop();
                Navigator.pop(
                    context, true); // Indica que uma consulta foi deletada
              },
              child: const Text('Confirmar', style: TextStyle(color: Color.fromARGB(220, 105, 126, 80),),),
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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: Text(
                    "Medicamentos",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(220, 105, 126, 80),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: medicamentos.length,
                    itemBuilder: (context, index) {
                      var medicamento = medicamentos[index];
                      return ListTile(
                        // onTap: () async {
                        //   bool? result = await Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) =>
                        //           InformacoesConsultas(modeloConsultas: consulta),
                        //     ),
                        //   );
                        //   if (result == true) {
                        //     _updateConsultas();
                        //   }
                        // },
                        title: Row(
                          children: [
                            Text(
                              '${medicamento.nome}: ${medicamento.horario}',
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                            const Spacer(),
                            PopupMenuButton(
                              itemBuilder: (BuildContext context) {
                                return <PopupMenuEntry>[
                                  const PopupMenuItem(
                                    value: 'edit',
                                    child: Center(
                                      child: Text('Editar'),
                                    ),
                                  ),
                                  const PopupMenuItem(
                                    value: 'delete',
                                    child: Center(
                                      child: Text('Deletar'),
                                    ),
                                  )
                                ];
                              },
                              icon: const Icon(Icons.more_vert,
                                  color: Color.fromARGB(
                                      220, 105, 126, 80)), // Ícone e cor
                              elevation: 8, // Elevação da sombra
                              color: const Color.fromARGB(
                                  255, 245, 246, 241), // Cor do botão
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    8.0), // Borda arredondada
                              ),
                              onSelected: (value) async {
                                if (value == 'edit') {
                                  await _editarConsulta(context);
                                } else if (value == 'delete') {
                                  await _exibirPopUpConfirmacao(
                                      context, medicamentoAtual.id);
                                }
                              },
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 10.0),
                //   child: GestureDetector(
                //     onTap: () {
                //       // Navigator.push(
                //       //   context,
                //       //   MaterialPageRoute(
                //       //       builder: (context) =>
                //       //           const HistoricoExames(tipo: 'Hemoglobina')),
                //       // );
                //     },
                //     child: SizedBox(
                //       height: 40,
                //       width: 450,
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           const Text(
                //             "Pantoprazol: 8h",
                //             style: TextStyle(
                //                 fontSize: 16, fontWeight: FontWeight.w900),
                //           ),
                //           IconButton(
                //             icon: const Icon(Icons.more_vert),
                //             onPressed: () {
                //               Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                     builder: (context) =>
                //                         const EditarMedicamento()),
                //               );
                //             },
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 10.0),
                //   child: GestureDetector(
                //     onTap: () {
                //       // Navigator.push(
                //       //   context,
                //       //   MaterialPageRoute(
                //       //       builder: (context) =>
                //       //           const HistoricoExames(tipo: "Colesterol Total")),
                //       // );
                //     },
                //     child: SizedBox(
                //       height: 40,
                //       width: 450,
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           const Text(
                //             "Paracetamol: 9h",
                //             style: TextStyle(
                //                 fontSize: 16, fontWeight: FontWeight.w900),
                //           ),
                //           IconButton(
                //             icon: const Icon(Icons.more_vert),
                //             onPressed: () {
                //               Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                     builder: (context) =>
                //                         const EditarMedicamento()),
                //               );
                //             },
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NovoMedicamento()),
            );
          },
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(15),
              backgroundColor: const Color.fromARGB(
                  50, 105, 126, 80), // Cor de fundo do botão
              foregroundColor: Colors.white,
              shape: const CircleBorder()),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
