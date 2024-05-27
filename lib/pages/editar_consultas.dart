import 'package:app_ye_gestao_de_saude/models/consultas_model.dart';
import 'package:app_ye_gestao_de_saude/pages/consultas.dart';
import 'package:app_ye_gestao_de_saude/pages/info_consultas.dart';
import 'package:app_ye_gestao_de_saude/pages/informacoes_consultas.dart';
import 'package:app_ye_gestao_de_saude/services/consultas_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditarConsultas extends StatefulWidget {
  final String consultaId;
  final String especialidade;
  final String horario;
  final String resumo;

  const EditarConsultas(
      {super.key,
      required this.consultaId,
      required this.especialidade,
      required this.horario,
      required this.resumo});

  @override
  State<EditarConsultas> createState() => _EditarConsultasState();
}

class _EditarConsultasState extends State<EditarConsultas> {
  final TimeOfDay _selectedTime = TimeOfDay.now();
  //  DateTime _selectedDate = DateTime.now();
  late DateTime _selectedDate;
  late DateTime _selectedRetorno;
  late DateTime _selectedLembrete;
  late TextEditingController horariocontroller = TextEditingController();
  late TextEditingController especialidadecontroller = TextEditingController();
  late TextEditingController resumocontroller = TextEditingController();
  late TextEditingController _lembreteController;

  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  final _formKey = GlobalKey<FormState>();
  final ConsultasService _consultationService = ConsultasService();

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedLembrete = DateTime.now();
    _selectedRetorno =
        DateTime.now(); // Inicializando _selectedDate com a data atual
    _lembreteController = TextEditingController();
    especialidadecontroller = TextEditingController(text: widget.especialidade);
    resumocontroller = TextEditingController(text: widget.resumo);
    horariocontroller = TextEditingController(text: widget.horario);
  }

  @override
  void dispose() {
    _lembreteController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    final DateTime? pickedData = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
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
    if (pickedData != null && pickedData != _selectedDate) {
      setState(() {
        _selectedDate = pickedData;
      });
    }
  }

  ConsultasService consultasService = ConsultasService();

  Future<void> _selectRetorno(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    final DateTime? pickedRetorno = await showDatePicker(
      context: context,
      initialDate: _selectedRetorno,
      firstDate: DateTime.now(), // Restringindo a data inicial para hoje
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
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
    if (pickedRetorno != null && pickedRetorno != _selectedRetorno) {
      setState(() {
        _selectedRetorno = pickedRetorno;
      });
    }
  }

  Future<void> _selectLembrete(BuildContext context) async {
    final ThemeData theme = Theme.of(context);

    final DateTime? pickedLembrete = await showDatePicker(
      context: context,
      initialDate: _selectedLembrete,
      firstDate: DateTime.now(), // Restringindo a data inicial para hoje
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
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
    if (pickedLembrete != null && pickedLembrete != _selectedLembrete) {
      setState(() {
        _selectedLembrete = pickedLembrete;
      });
    }
  }

  ConsultasService dbService = ConsultasService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 246, 241),
      body: StreamBuilder(
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

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(70, 20, 70, 0),
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
                          height: 40,
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
                              child: TextFormField(
                                controller: especialidadecontroller,
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
                                      color:
                                          Color.fromARGB(255, 152, 152, 152)),
                                  //quando clica na label
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color.fromARGB(220, 105, 126,
                                              80)), // Altere a cor da borda aqui
                                      borderRadius: BorderRadius.circular(18)),
                                ),
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Por favor, insira sua glicemia';
                                //   }
                                //   return null;
                                // },
                                // onSaved: (value) {
                                //   if (value != null) {
                                //     _glicemia = value;
                                //   }
                                // },
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
                              child: TextFormField(
                                readOnly: true,
                                onTap: () => _selectDate(context),
                                controller: TextEditingController(
                                  text: _selectedDate != null
                                      ? _dateFormat.format(_selectedDate!)
                                      : '',
                                ),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color.fromARGB(
                                              220, 105, 126, 80)),
                                      borderRadius: BorderRadius.circular(18)),

                                  contentPadding:
                                      const EdgeInsets.fromLTRB(25, 0, 0, 0),
                                  labelStyle: const TextStyle(
                                      fontSize: 18,
                                      color:
                                          Color.fromARGB(255, 152, 152, 152)),
                                  //quando clica na label
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color.fromARGB(220, 105, 126,
                                              80)), // Altere a cor da borda aqui
                                      borderRadius: BorderRadius.circular(18)),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, insira uma data';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.datetime,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedDate = DateTime.tryParse(value)!;
                                  });
                                },
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
                              child: TextFormField(
                                controller: horariocontroller,
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
                                      color:
                                          Color.fromARGB(255, 152, 152, 152)),
                                  //quando clica na label
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color.fromARGB(220, 105, 126,
                                              80)), // Altere a cor da borda aqui
                                      borderRadius: BorderRadius.circular(18)),
                                ),
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Por favor, insira sua glicemia';
                                //   }
                                //   return null;
                                // },
                                // onSaved: (value) {
                                //   if (value != null) {
                                //     _glicemia = value;
                                //   }
                                // },
                              ),
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              "Resumo da consulta:",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(220, 105, 126, 80),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 40,
                              child: TextFormField(
                                controller: resumocontroller,
                                keyboardType: TextInputType.multiline,
                                maxLines: null, // Permite várias linhas
                                textAlignVertical: TextAlignVertical.top,
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
                                      color:
                                          Color.fromARGB(255, 152, 152, 152)),
                                  //quando clica na label
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color.fromARGB(220, 105, 126,
                                              80)), // Altere a cor da borda aqui
                                      borderRadius: BorderRadius.circular(18)),
                                ),
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Por favor, insira sua glicemia';
                                //   }
                                //   return null;
                                // },
                                // onSaved: (value) {
                                //   if (value != null) {
                                //     _glicemia = value;
                                //   }
                                // },
                              ),
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              "Retorno em:",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(220, 105, 126, 80),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 40,
                              child: TextFormField(
                                readOnly: true,
                                onTap: () => _selectRetorno(context),
                                controller: TextEditingController(
                                  text: _selectedRetorno != null
                                      ? _dateFormat.format(_selectedRetorno!)
                                      : '',
                                ),
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
                                      color:
                                          Color.fromARGB(255, 152, 152, 152)),
                                  //quando clica na label
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color.fromARGB(220, 105, 126,
                                              80)), // Altere a cor da borda aqui
                                      borderRadius: BorderRadius.circular(18)),
                                ),
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'Por favor, insira sua glicemia';
                                //   }
                                //   return null;
                                // },
                                // onSaved: (value) {
                                //   if (value != null) {
                                //     _glicemia = value;
                                //   }
                                // },
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
                              child: TextFormField(
                                // controller: _lembreteController,
                                readOnly:
                                    true, // Impede a edição direta do campo
                                onTap: () => _selectLembrete(context),
                                controller: TextEditingController(
                                  text: _selectedLembrete != null
                                      ? _dateFormat.format(_selectedLembrete!)
                                      : '', // Ao clicar, abrirá o seletor de data
                                ),
                                keyboardType: TextInputType.datetime,
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
                                      color:
                                          Color.fromARGB(255, 152, 152, 152)),
                                  //quando clica na label
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color.fromARGB(220, 105, 126,
                                              80)), // Altere a cor da borda aqui
                                      borderRadius: BorderRadius.circular(18)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                // InformacoesConsultas(
                                //   modeloConsultas: ModeloConsultas(
                                //       id: '',
                                //       especialidade: especialidade,
                                //       horario: horario,
                                //       data: data,
                                //       resumo: resumo,
                                //       retorno: retorno,
                                //       lembrete: lembrete),
                                // )
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets
                                    .zero, // Define o padding do botão como zero para não interferir com o padding do widget interno
                                backgroundColor:
                                    const Color.fromARGB(50, 105, 126, 80),
                                foregroundColor: const Color.fromARGB(255, 255,
                                    255, 255), // Cor de fundo do botão
                                shape: const CircleBorder(),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(
                                    8), // Espaçamento interno para o ícone
                                child: Icon(Icons.close),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                final especialidade =
                                    especialidadecontroller.text;
                                final data = _selectedDate != null
                                    ? DateFormat('dd/MM/yyyy')
                                        .format(_selectedDate!)
                                    : '';
                                final retorno = _selectedRetorno != null
                                    ? DateFormat('dd/MM/yyyy')
                                        .format(_selectedRetorno!)
                                    : '';
                                final lembrete = _selectedLembrete != null
                                    ? DateFormat('dd/MM/yyyy')
                                        .format(_selectedLembrete!)
                                    : '';
                                final resumo = resumocontroller.text;
                                final horario = _selectedTime != null
                                    ? _selectedTime.format(context)
                                    : '';

                                if (especialidade.isNotEmpty &&
                                    horario.isNotEmpty &&
                                    data.isNotEmpty &&
                                    resumo.isNotEmpty &&
                                    retorno.isNotEmpty &&
                                    lembrete.isNotEmpty) {
                                  final consulta = ModeloConsultas(
                                    id: '',
                                    especialidade: especialidade,
                                    horario: horario,
                                    data: data,
                                    resumo: resumo,
                                    retorno: retorno,
                                    lembrete: lembrete,
                                  );

                                  // Chamada para a função que realiza a edição da consulta
                                  await consultasService.editarConsulta(
                                      widget.consultaId, consulta);

                                  // Navegação para a página de informações da consulta
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          InformacoesConsultas(
                                        modeloConsultas: consulta,
                                      ),
                                    ),
                                  );
                                } else {
                                  // Se algum campo estiver vazio, exiba uma mensagem ou realize outra ação adequada
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Todos os campos são obrigatórios'),
                                    ),
                                  );
                                }
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
                      ])),
                ),
              ),
            );
          }),
    );
  }
}
