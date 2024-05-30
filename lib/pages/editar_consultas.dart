import 'package:app_ye_gestao_de_saude/models/consultas_model.dart';
import 'package:app_ye_gestao_de_saude/pages/consultas.dart';
import 'package:app_ye_gestao_de_saude/pages/info_consultas.dart';
import 'package:app_ye_gestao_de_saude/services/consultas_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

class EditarConsultas extends StatefulWidget {
  final ModeloConsultas modeloConsultas;

  const EditarConsultas({super.key, required this.modeloConsultas});

  @override
  _EditarConsultasState createState() => _EditarConsultasState();
}

class _EditarConsultasState extends State<EditarConsultas> {
  late TextEditingController especialidadeController;
  late TextEditingController dataController;
  late TextEditingController horarioController;
  late TextEditingController resumoController;
  late TextEditingController retornoController;
  late TextEditingController lembreteController;

  late DateFormat dateFormatter;
  late DateFormat timeFormatter;

  @override
  void initState() {
    super.initState();
    especialidadeController =
        TextEditingController(text: widget.modeloConsultas.especialidade);
    dataController = TextEditingController(text: widget.modeloConsultas.data);
    horarioController =
        TextEditingController(text: widget.modeloConsultas.horario);
    resumoController =
        TextEditingController(text: widget.modeloConsultas.resumo);
    retornoController = TextEditingController();
    lembreteController = TextEditingController();

    if (widget.modeloConsultas.retorno != null &&
        widget.modeloConsultas.retorno!.isNotEmpty) {
      retornoController.text = widget.modeloConsultas.retorno!;
    } else {
      retornoController.text = 'Escolha uma data';
    }

    if (widget.modeloConsultas.lembrete != null &&
        widget.modeloConsultas.lembrete!.isNotEmpty) {
      lembreteController.text = widget.modeloConsultas.lembrete!;
    } else {
      lembreteController.text = 'Escolha uma data';
    }

    dateFormatter = DateFormat('dd/MM/yyyy');
    timeFormatter = DateFormat('HH:mm');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 246, 241),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 245, 246, 241),
        elevation: 0,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(70, 0, 70, 0),
          child: Center(
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const Wrap(children: [
                    Text(
                      'Edite sua consulta',
                      style: TextStyle(
                        fontSize: 22,
                        color: Color.fromARGB(220, 105, 126, 80),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ]),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Especialidade:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(220, 105, 126, 80),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: especialidadeController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(220, 105, 126,
                                        80)), // Altere a cor da borda aqui

                                borderRadius: BorderRadius.circular(18)),
                            contentPadding:
                                const EdgeInsets.fromLTRB(25, 0, 0, 0),
                            labelStyle: const TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 152, 152, 152)),
                            //quando clica na label
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(220, 105, 126,
                                        80)), // Altere a cor da borda aqui
                                borderRadius: BorderRadius.circular(18)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "Data:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(220, 105, 126, 80),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: dataController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(220, 105, 126,
                                        80)), // Altere a cor da borda aqui

                                borderRadius: BorderRadius.circular(18)),
                            contentPadding:
                                const EdgeInsets.fromLTRB(25, 0, 0, 0),
                            labelStyle: const TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 152, 152, 152)),
                            //quando clica na label
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(220, 105, 126,
                                        80)), // Altere a cor da borda aqui
                                borderRadius: BorderRadius.circular(18)),
                          ),
                          readOnly: true,
                          onTap: () => _selectData(context),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "Horário:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(220, 105, 126, 80),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: horarioController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(220, 105, 126,
                                        80)), // Altere a cor da borda aqui

                                borderRadius: BorderRadius.circular(18)),
                            contentPadding:
                                const EdgeInsets.fromLTRB(25, 0, 0, 0),
                            labelStyle: const TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 152, 152, 152)),
                            //quando clica na label
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(220, 105, 126,
                                        80)), // Altere a cor da borda aqui
                                borderRadius: BorderRadius.circular(18)),
                          ),
                          readOnly: true,
                          onTap: () => _selectTime(context),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "Resumo:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(220, 105, 126, 80),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: resumoController,
                          keyboardType: TextInputType.multiline,
                          maxLines: null, // Permite várias linhas
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(220, 105, 126,
                                        80)), // Altere a cor da borda aqui

                                borderRadius: BorderRadius.circular(18)),
                            contentPadding:
                                const EdgeInsets.fromLTRB(25, 0, 0, 0),
                            labelStyle: const TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 152, 152, 152)),
                            //quando clica na label
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(220, 105, 126,
                                        80)), // Altere a cor da borda aqui
                                borderRadius: BorderRadius.circular(18)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "Retorno:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(220, 105, 126, 80),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: retornoController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(220, 105, 126,
                                        80)), // Altere a cor da borda aqui

                                borderRadius: BorderRadius.circular(18)),
                            contentPadding:
                                const EdgeInsets.fromLTRB(25, 0, 0, 0),
                            labelStyle: const TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 152, 152, 152)),
                            //quando clica na label
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(220, 105, 126,
                                        80)), // Altere a cor da borda aqui
                                borderRadius: BorderRadius.circular(18)),
                          ),
                          onTap: () => _selectRetorno(context),
                          readOnly: true,
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "Lembrete para agendamento:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(220, 105, 126, 80),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 40,
                        child: TextField(
                          controller: lembreteController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(220, 105, 126,
                                        80)), // Altere a cor da borda aqui

                                borderRadius: BorderRadius.circular(18)),
                            contentPadding:
                                const EdgeInsets.fromLTRB(25, 0, 0, 0),
                            labelStyle: const TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 152, 152, 152)),
                            //quando clica na label
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(220, 105, 126,
                                        80)), // Altere a cor da borda aqui
                                borderRadius: BorderRadius.circular(18)),
                          ),
                          onTap: () => _selectLembrete(context),
                          readOnly: true,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => InformacoesConsultas(modeloConsultas: modeloConsultas),
                              //   ),
                              // );
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets
                                  .zero, // Define o padding do botão como zero para não interferir com o padding do widget interno
                              backgroundColor:
                                  const Color.fromARGB(50, 105, 126, 80),
                              foregroundColor: const Color.fromARGB(
                                  255, 255, 255, 255), // Cor de fundo do botão
                              shape: const CircleBorder(),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(
                                  8), // Espaçamento interno para o ícone
                              child: Icon(Icons.close),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              ModeloConsultas consultaAtualizada =
                                  ModeloConsultas(
                                id: widget.modeloConsultas.id,
                                especialidade: especialidadeController.text,
                                data: dataController.text,
                                horario: horarioController.text,
                                resumo: resumoController.text,
                                retorno: retornoController.text,
                                lembrete: lembreteController.text,
                              );

                              await ConsultasService().editarConsulta(
                                consultaAtualizada.id,
                                consultaAtualizada.especialidade,
                                consultaAtualizada.data,
                                consultaAtualizada.horario,
                                consultaAtualizada.resumo,
                                consultaAtualizada.retorno,
                                consultaAtualizada.lembrete,
                              );

                              Navigator.pop(context, consultaAtualizada);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(50, 105, 126, 80),
                              foregroundColor: Colors.white,
                              shape: const CircleBorder(),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8),
                              child: Icon(Icons.check),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectData(BuildContext context) async {
        final ThemeData theme = Theme.of(context);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: null,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      helpText: 'Selecione a data',
      cancelText: 'Cancelar',
      confirmText: 'Confirmar',
      fieldLabelText: 'Informe a data',
      errorFormatText: 'Formato de data inválido',
      errorInvalidText: 'Data inválida',
      builder: (context, child) {
        return Theme(
          data: theme.copyWith(
            // Personalize a cor de fundo da seleção aqui
            colorScheme: theme.colorScheme.copyWith(
              primary: const Color.fromARGB(
                  220, 105, 126, 80), // Cor de fundo da seleção
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      setState(() {
        dataController.text = dateFormatter.format(pickedDate);
      });
    }
  }

  Future<void> _selectRetorno(BuildContext context) async {
            final ThemeData theme = Theme.of(context);

    final DateTime? pickedRetorno = await showDatePicker(
      context: context,
      initialDate: null,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      helpText: 'Selecione a data',
      cancelText: 'Cancelar',
      confirmText: 'Confirmar',
      fieldLabelText: 'Informe a data',
      errorFormatText: 'Formato de data inválido',
      errorInvalidText: 'Data inválida',
      builder: (context, child) {
        return Theme(
          data: theme.copyWith(
            // Personalize a cor de fundo da seleção aqui
            colorScheme: theme.colorScheme.copyWith(
              primary: const Color.fromARGB(
                  220, 105, 126, 80), // Cor de fundo da seleção
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedRetorno != null) {
      setState(() {
        retornoController.text = dateFormatter.format(pickedRetorno);
      });
    }
  }

  Future<void> _selectLembrete(BuildContext context) async {
            final ThemeData theme = Theme.of(context);

    final DateTime? pickedLembrete = await showDatePicker(
      context: context,
      initialDate: null,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      helpText: 'Selecione a data',
      cancelText: 'Cancelar',
      confirmText: 'Confirmar',
      fieldLabelText: 'Informe a data',
      errorFormatText: 'Formato de data inválido',
      errorInvalidText: 'Data inválida',
      builder: (context, child) {
        return Theme(
          data: theme.copyWith(
            // Personalize a cor de fundo da seleção aqui
            colorScheme: theme.colorScheme.copyWith(
              primary: const Color.fromARGB(
                  220, 105, 126, 80), // Cor de fundo da seleção
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedLembrete != null) {
      setState(() {
        lembreteController.text = dateFormatter.format(pickedLembrete);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color.fromARGB(220, 105, 126, 80), // Cor primária
              secondary: Color.fromARGB(220, 105, 126, 80),
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedTime != null) {
      setState(() {
        // Convertendo TimeOfDay para DateTime para formatar corretamente
        final selectedDateTime =
            DateTime(0, 1, 1, pickedTime.hour, pickedTime.minute);
        // Formatação com AM/PM
        horarioController.text = DateFormat('hh:mm a').format(selectedDateTime);
      });
    }
  }

  @override
  void dispose() {
    especialidadeController.dispose();
    dataController.dispose();
    horarioController.dispose();
    resumoController.dispose();
    retornoController.dispose();
    lembreteController.dispose();
    super.dispose();
  }
}
