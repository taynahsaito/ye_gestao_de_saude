import 'package:app_ye_gestao_de_saude/models/consultas_model.dart';
import 'package:app_ye_gestao_de_saude/services/consultas_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class NovaConsulta extends StatefulWidget {
  const NovaConsulta({super.key});

  @override
  State<NovaConsulta> createState() => _NovaConsultaState();
}

class _NovaConsultaState extends State<NovaConsulta> {
  late DateTime? _selectedDate;
  late DateTime? _selectedRetorno;
  late DateTime? _selectedLembrete;
  final TextEditingController horariocontroller = TextEditingController();
  final TextEditingController especialidadecontroller = TextEditingController();
  final TextEditingController resumocontroller = TextEditingController();

  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _selectedDate = null;
    _selectedLembrete = null;
    _selectedRetorno = null; // Inicializando _selectedDate com a data atual
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

  Future<void> _selectRetorno(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    final DateTime? pickedRetorno = await showDatePicker(
      context: context,
      initialDate: _selectedRetorno,
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
    if (pickedLembrete != null && pickedLembrete != _selectedLembrete) {
      setState(() {
        _selectedLembrete = pickedLembrete;
      });
    }
  }

  final ConsultasService adicionarConsulta = ConsultasService();

  consultaAdicionar() {
    String especialidade = especialidadecontroller.text;
    String resumo = resumocontroller.text;
    String horario = horariocontroller.text;
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
                    'Registre uma nova consulta',
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
                        readOnly: true,
                        onTap: () => _selectLembrete(context),
                        controller: TextEditingController(
                          text: _selectedLembrete != null
                              ? _dateFormat.format(_selectedLembrete!)
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
                  ],
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
                        backgroundColor: const Color.fromARGB(50, 105, 126, 80),
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
                        Navigator.of(context).pop();
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
              ],
            )),
          ),
        ),
      ),
    );
  }
}
