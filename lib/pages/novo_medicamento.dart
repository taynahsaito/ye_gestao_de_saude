import 'package:app_ye_gestao_de_saude/models/medicamentos_model.dart';
import 'package:app_ye_gestao_de_saude/services/medicamentos_service.dart';
import 'package:app_ye_gestao_de_saude/widgets/multiple_date_selection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class NovoMedicamento extends StatefulWidget {
  const NovoMedicamento({super.key});

  @override
  State<NovoMedicamento> createState() => _NovoMedicamentoState();
}

class _NovoMedicamentoState extends State<NovoMedicamento> {
  final _formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  late TextEditingController horarioController;
  final intervaloController = TextEditingController();
  // final _periodoController = TextEditingController();
  late DateTime? _selectedTime;
  late DateFormat timeFormatter;

  late DateTime? _selectedPeriodo;
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    _selectedPeriodo = null;
    _selectedTime = null;
    horarioController = TextEditingController();
    timeFormatter = DateFormat('HH:mm');
  }

  Future<void> _selectPeriodo(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedPeriodo,
      firstDate: DateTime.now(),
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
    if (picked != null && picked != _selectedPeriodo) {
      setState(() {
        _selectedPeriodo = picked;
      });
    }
  }
  // Future<void> _selectPeriodo(BuildContext context) async {
  //   final pickedDates = await showDialog<Set<DateTime>>(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: const Text('Selecione as datas'),
  //         content: MultipleDateSelection(
  //           selectedDates: _selectedPeriodo,
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop(_selectedPeriodo);
  //             },
  //             child: const Text('OK'),
  //           ),
  //         ],
  //       );
  //     },
  //   );

  //   if (pickedDates != null && pickedDates.isNotEmpty) {
  //     setState(() {
  //       _selectedPeriodo = pickedDates as DateTime?;
  //     });
  //   }
  // }

  @override
  void dispose() {
    nomeController.dispose();
    horarioController.dispose();
    intervaloController.dispose();
    // _periodoController.dispose();
    super.dispose();
  }

  final MedicamentosService adicionarMedicamento = MedicamentosService();

  medicamentoAdicionar() {
    String nome = nomeController.text;
    String horario = horarioController.text;
    String intervalo = intervaloController.text;
    String periodo = _dateFormat.format(_selectedPeriodo!);

    ModeloMedicamentos modeloMedicamentos = ModeloMedicamentos(
        id: const Uuid().v1(),
        nome: nome,
        horario: horario,
        intervaloHoras: intervalo,
        periodoTomado: periodo);

    adicionarMedicamento.adicionarMedicamento(modeloMedicamentos);
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
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
          // _selectedPeriodo!.year,
          // _selectedPeriodo!.month,
          // _selectedPeriodo!.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        horarioController.text = pickedTime.format(
            context); // Atualiza o texto do campo de texto com a hora selecionada
      });
    }
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
                  child: Text(
                    'Registre um novo medicamento',
                    style: TextStyle(
                      fontSize: 22,
                      color: Color.fromARGB(220, 105, 126, 80),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  child: Padding(
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
                            controller: nomeController,
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
                                      color: Color.fromARGB(220, 105, 126, 80)),
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor, insira o nome do medicamento';
                              }
                              return null;
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
                            controller: intervaloController,
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
                            onTap: () => _selectPeriodo(context),
                            controller: TextEditingController(
                              text: _selectedPeriodo != null
                                  ? _dateFormat.format(_selectedPeriodo!)
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
                        // if (_formKey.currentState!.validate()) {
                        //   // Aqui você pode atualizar os dados do paciente
                        //   nomeController.clear();
                        //   horarioController.clear();
                        //   intervaloController.clear();
                        //   .clear();
                        // }
                        await medicamentoAdicionar();
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
            ),
          ),
        ),
      ),
    );
  }
}
