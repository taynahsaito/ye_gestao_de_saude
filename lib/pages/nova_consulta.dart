import 'package:app_ye_gestao_de_saude/models/consultas_model.dart';
import 'package:app_ye_gestao_de_saude/services/consultas_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class NovaConsulta extends StatefulWidget {
  final TextEditingController especialidade;
  final Function? onUpdateConsulta;
  const NovaConsulta(
      {Key? key, required this.especialidade, this.onUpdateConsulta})
      : super(key: key);

  @override
  State<NovaConsulta> createState() => _NovaConsultaState();
}

class _NovaConsultaState extends State<NovaConsulta> {
  late DateFormat timeFormatter;
  late DateTime? _selectedDate;
  late DateTime? _selectedTime;
  late DateTime? _selectedRetorno;
  late DateTime? _selectedLembrete;
  late TextEditingController horarioController;
  late TextEditingController especialidadeController = TextEditingController();
  final TextEditingController resumocontroller = TextEditingController();

  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _selectedDate = null;
    _selectedTime = null;
    _selectedLembrete = null;
    _selectedRetorno = null;
    especialidadeController.text = widget.especialidade.text;
    horarioController = TextEditingController();
    timeFormatter = DateFormat('HH:mm');
  }

  @override
  void dispose() {
    horarioController.dispose();
    especialidadeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedData = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Color.fromARGB(220, 105, 126, 80),
              secondary: Color.fromARGB(220, 105, 126, 80),
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

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Color.fromARGB(220, 105, 126, 80),
              secondary: Color.fromARGB(220, 105, 126, 80),
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedTime != null) {
      setState(() {
        // Convertendo o TimeOfDay selecionado para DateTime
        _selectedTime = DateTime(
          _selectedDate!.year,
          _selectedDate!.month,
          _selectedDate!.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        horarioController.text = pickedTime.format(
            context); // Atualiza o texto do campo de texto com a hora selecionada
      });
    }
  }

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

  final ConsultasService adicionarConsulta = ConsultasService();

  consultaAdicionar() {
    String especialidade = especialidadeController.text;
    String resumo = resumocontroller.text;
    String horario = horarioController.text;
    String data = _dateFormat.format(_selectedDate!);
    String retorno = _dateFormat.format(_selectedRetorno!);
    String lembrete = _dateFormat.format(_selectedLembrete!);

    ModeloConsultas modeloConsultas = ModeloConsultas(
        id: const Uuid().v1(),
        especialidade: especialidade,
        horario: horario,
        data: data,
        resumo: resumo,
        retorno: retorno,
        lembrete: lembrete);

    adicionarConsulta.adicionarConsulta(modeloConsultas);
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
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Form(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Wrap(children: [
                      Text(
                        'Registre uma nova consulta',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(220, 105, 126, 80),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ]),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(70, 0, 70, 0),
                    child: Column(
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
                            controller: widget.especialidade,
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
                                      color: Color.fromARGB(220, 105, 126, 80)),
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira uma data';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.datetime,
                            onChanged: (value) {
                              setState(() {
                                _selectedDate = DateTime.tryParse(value);
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
                            controller: horarioController,
                            readOnly: true,
                            onTap: () => _selectTime(context),
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
                                  color: Color.fromARGB(255, 152, 152, 152)),
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
                                  color: Color.fromARGB(255, 152, 152, 152)),
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
                            readOnly: true, // Impede a edição direta do campo
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _formKey.currentState!.reset();
                          setState(() {
                            _selectedDate = null;
                            _selectedLembrete = null;
                            _selectedRetorno = null;
                          });
                          Navigator.of(context).pop();
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
                      ElevatedButton(
                        onPressed: () async {
                          // Navigator.of(context).pop();
                          // if (_formKey.currentState != null &&
                          //     _formKey.currentState!.validate()) {
                          //   _formKey.currentState!.save();
                          //   if (_selectedDate != null) {
                          //     // Aqui você pode salvar os dados em um banco de dados
                          //     // ou enviá-los para onde desejar
                          //     print('Glicemia: $_glicemia, Data: $_selectedDate');
                          //     // Exemplo de como limpar o formulário depois de enviar
                          //     _formKey.currentState!.reset();
                          //     setState(() {
                          //       _selectedDate = null;
                          //     });
                          //   } else {
                          //     ScaffoldMessenger.of(context).showSnackBar(
                          //       const SnackBar(
                          //         content:
                          //             Text('Por favor, insira uma data válida'),
                          //         duration: Duration(seconds: 2),
                          //       ),
                          //     );
                          await consultaAdicionar();
                          if (widget.onUpdateConsulta != null) {
                            widget
                                .onUpdateConsulta!(); // Chamando a função de retorno
                          }
                          Navigator.of(context).pop();
                          especialidadeController.clear();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                              50, 105, 126, 80), // Cor de fundo do botão
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
        ));
  }
}
