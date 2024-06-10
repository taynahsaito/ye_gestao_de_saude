import 'package:app_ye_gestao_de_saude/models/imc_model.dart';
import 'package:app_ye_gestao_de_saude/pages/imc.dart';
import 'package:app_ye_gestao_de_saude/services/imc_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class NovoIMC extends StatefulWidget {
  const NovoIMC({super.key});

  @override
  State<NovoIMC> createState() => _NovoIMCState();
}

class _NovoIMCState extends State<NovoIMC> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _alturaController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();
  final IMCService dbService = IMCService();

  late DateTime? _selectedDate;
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    _selectedDate = null; // Inicializando _selectedDate com a data atual
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

  final IMCService adicionarIMC = IMCService();

  imcAdicionar() {
    double peso = double.tryParse(_pesoController.text) ?? 0;
    double altura = double.tryParse(_alturaController.text) ?? 0;
    String data = _dateFormat.format(_selectedDate!);

    // Calcular IMC
    double imc = peso / (altura * altura);
    String imcString = imc.toStringAsFixed(2);

    // Criando uma instância do modelo IMC
    ModeloIMC modeloIMC = ModeloIMC(
      id: const Uuid().v1(),
      peso: peso.toString(),
      altura: altura.toString(),
      data: data,
      imc: imcString,
    );

    // Adicionando o IMC ao banco de dados
    adicionarIMC.adicionarIMC(modeloIMC);
  }

  @override
  void dispose() {
    _pesoController.dispose();
    _alturaController.dispose();
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(70, 0, 70, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                    height: 20), // Espaço adicionado acima do formulário
                const Text(
                  'Calcule seu IMC',
                  style: TextStyle(
                    fontSize: 22,
                    color: Color.fromARGB(220, 105, 126, 80),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Altura (em metros):",
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
                        controller: _alturaController,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira a altura';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(220, 105, 126,
                                      80)), // Altere a cor da borda aqui

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
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Peso (em kg):",
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
                        controller: _pesoController,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira o peso';
                          }
                          return null;
                        },
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
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Data da aferição:",
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
                        keyboardType: TextInputType.datetime,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira a data da aferição';
                          }
                          return null;
                        },
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
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
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
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            imcAdicionar();
                            _alturaController.clear();
                            _pesoController.clear();
                            _selectedDate = null;
                          });
                          // String altura = _alturaController.text.trim();
                          // String peso = _pesoController.text.trim();

                          // String imc = ModeloIMC.calcularIMC(peso, altura);
                          // await dbService.adicionarIMC(
                          //   ModeloIMC(
                          //     id: '',
                          //     altura: altura,
                          //     peso: peso,
                          //     data: _selectedDate != null
                          //         ? _dateFormat.format(_selectedDate!)
                          //         : '',
                          //     imc: imc,
                          //   ),
                          // );
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('IMC cadastrado com sucesso!')),
                        );
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
                      ), // Ícone de errado com cor verde #697E50
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
