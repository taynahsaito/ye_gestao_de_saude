import 'package:app_ye_gestao_de_saude/models/medicamentos_model.dart';
import 'package:app_ye_gestao_de_saude/pages/editar_medicamento.dart';
import 'package:app_ye_gestao_de_saude/pages/novo_medicamento.dart';
import 'package:app_ye_gestao_de_saude/services/medicamentos_service.dart';
import 'package:flutter/material.dart';

class Medicamentos extends StatefulWidget {
  const Medicamentos({Key? key});

  @override
  State<Medicamentos> createState() => _MedicamentosState();
}

class _MedicamentosState extends State<Medicamentos> {
  final MedicamentosService medicamentosService = MedicamentosService();
  final MedicamentosService dbService = MedicamentosService();
  // final ModeloMedicamentos medicamentoAtual = ModeloMedicamentos(id: '', nome: nome, horario: horario, intervaloHoras: intervaloHoras, periodoTomado: periodoTomado);

  // @override
  // void initState() {
  //   super.initState();
  //   medicamentoAtual = ;
  // }

  Future<void> _editarMedicamento(
      BuildContext context, ModeloMedicamentos medicamento) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditarMedicamento(
          modeloMedicamentos: medicamento,
        ),
      ),
    );

    if (result != null && result is ModeloMedicamentos) {
      setState(() {
        medicamento = result;
      });
    }
  }

  Future<void> _exibirPopUpConfirmacao(
      BuildContext context, String idMedicamento) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Deletar medicamento'),
          content:
              const Text('Tem certeza de que deseja excluir este medicamento?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancelar',
                style: TextStyle(
                  color: Color.fromARGB(220, 105, 126, 80),
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                await medicamentosService.deletarMedicamento(idMedicamento);
                // Navigator.of(context).pop();
                Navigator.pop(
                    context, true); // Indica que uma consulta foi deletada
              },
              child: const Text(
                'Confirmar',
                style: TextStyle(
                  color: Color.fromARGB(220, 105, 126, 80),
                ),
              ),
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
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 90, 20, 30),
                child: Center(
                  child: Text(
                    'Medicamentos',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(220, 105, 126, 80),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<List<ModeloMedicamentos>>(
                  stream: medicamentosService.getMedicamentos(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    var medicamentos = snapshot.data!;

                    return ListView.builder(
                      itemCount: medicamentos.length,
                      itemBuilder: (context, index) {
                        var medicamento = medicamentos[index];

                        return ListTile(
                          title: Row(
                            children: [
                              Text(
                                '${medicamento.nome}: ${medicamento.horario}',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                              Spacer(),
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
                                    await _editarMedicamento(
                                        context, medicamento);
                                  } else if (value == 'delete') {
                                    await _exibirPopUpConfirmacao(
                                        context, medicamento.id);
                                  }
                                },
                              )
                            ],
                          ),
                        );
                      },
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
                        builder: (context) => const NovoMedicamento()),
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
