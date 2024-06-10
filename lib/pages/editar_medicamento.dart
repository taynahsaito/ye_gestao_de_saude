import 'package:app_ye_gestao_de_saude/models/medicamentos_model.dart';
import 'package:app_ye_gestao_de_saude/services/medicamentos_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditarMedicamento extends StatefulWidget {
  final ModeloMedicamentos modeloMedicamentos;
  const EditarMedicamento({super.key, required this.modeloMedicamentos});

  @override
  State<EditarMedicamento> createState() => _EditarMedicamentoState();
}

class _EditarMedicamentoState extends State<EditarMedicamento> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomeController;
  late TextEditingController _horarioController;
  late TextEditingController _intervaloController;
  late TextEditingController _periodoController;
  late DateTime? _selectedDate;
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  late DateFormat dateFormatter;
  late DateFormat timeFormatter;

  @override
  void initState() {
    super.initState();
    _nomeController =
        TextEditingController(text: widget.modeloMedicamentos.nome);
    _horarioController =
        TextEditingController(text: widget.modeloMedicamentos.horario);
    _intervaloController =
        TextEditingController(text: widget.modeloMedicamentos.intervaloHoras);
    _periodoController =
        TextEditingController(text: widget.modeloMedicamentos.periodoTomado);
    _selectedDate = DateTime.now();
    dateFormatter = DateFormat('dd/MM/yyyy');
    timeFormatter = DateFormat('HH:mm');
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
        _horarioController.text =
            DateFormat('hh:mm a').format(selectedDateTime);
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    final DateTime? picked = await showDatePicker(
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
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _horarioController.dispose();
    _intervaloController.dispose();
    _periodoController.dispose();
    super.dispose();
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
                  padding: EdgeInsets.fromLTRB(70, 0, 70, 0),
                  child: Wrap(children: [
                    Text(
                      'Editar medicamento',
                      style: TextStyle(
                        fontSize: 22,
                        color: Color.fromARGB(220, 105, 126, 80),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ]),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.fromLTRB(70, 0, 70, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Nome do medicamento:",
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
                          controller: _nomeController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(220, 105, 126,
                                        80)), // Altere a cor da borda aqui

                                borderRadius: BorderRadius.circular(28)),
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
                          controller: _horarioController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(220, 105, 126, 80)),
                                borderRadius: BorderRadius.circular(20)),

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
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          readOnly: true,
                          onTap: () => _selectTime(context),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira o horário';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "Intervalo de horas",
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
                          controller: _intervaloController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color.fromARGB(220, 105, 126, 80)),
                                borderRadius: BorderRadius.circular(20)),

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
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira o intervalo de horas';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 15.0),
                      const Text(
                        "Período de dias em que o medicamento será tomado:",
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
                                borderRadius: BorderRadius.circular(20)),

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
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, digite o período de dias que o medicamento será tomado';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      // const Icon(
                      //   Icons.send,
                      //   size: 30.0,),
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
                        ModeloMedicamentos medicamentoAtualizado =
                            ModeloMedicamentos(
                          id: widget.modeloMedicamentos.id,
                          nome: _nomeController.text,
                          horario: _horarioController.text,
                          intervaloHoras: _intervaloController.text,
                          periodoTomado: _periodoController.text,
                        );
                        await MedicamentosService().editarMedicamento(
                            medicamentoAtualizado.id,
                            medicamentoAtualizado.nome,
                            medicamentoAtualizado.horario,
                            medicamentoAtualizado.intervaloHoras,
                            medicamentoAtualizado.periodoTomado);

                        Navigator.pop(context, medicamentoAtualizado);
                        // if (_formKey.currentState!.validate()) {
                        //   // Aqui você pode atualizar os dados do paciente
                        //   _nomeController.clear();
                        //   _horarioController.clear();
                        //   _intervaloController.clear();
                        //   // _periodoController.clear();
                        // }
                        // Navigator.of(context).pop();
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
            ),
          ),
        ),
      ),
    );
  }
}
