import 'package:app_ye_gestao_de_saude/models/modelo_pressao.dart';
import 'package:app_ye_gestao_de_saude/services/pressao_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class NovaPressao extends StatefulWidget {
  const NovaPressao({super.key});

  @override
  State<NovaPressao> createState() => _NovaPressaoState();
}

class _NovaPressaoState extends State<NovaPressao> {
  //final TextEditingController sistolica = _sistolicaController;

  final _formKey = GlobalKey<FormState>();
  //final _dataController = TextEditingController();
  late DateTime? _selectedDate;
  final _sistolicaController = TextEditingController();
  final _diastolicaController = TextEditingController();
  final List<String> _pressaoData = [];

  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    _selectedDate = null;
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

  final PressaoService adicionarPressao = PressaoService();

  pressaoAdicionar() {
    String sistolica = _sistolicaController.text;
    String diastolica = _diastolicaController.text;
    String data = _dateFormat.format(_selectedDate!);

    ModeloPressao modeloPressao = ModeloPressao(
      id: const Uuid().v1(),
      sistolica: sistolica,
      diastolica: diastolica,
      data: data,
    );

    adicionarPressao.adicionarPressao(modeloPressao);
  }

  @override
  void dispose() {
    _sistolicaController.dispose();
    _diastolicaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 246, 241),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 245, 246, 241),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(220, 105, 126, 80),
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
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'Registre sua pressão',
                style: TextStyle(
                  fontSize: 22,
                  color: Color.fromARGB(220, 105, 126, 80),
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.fromLTRB(70, 0, 70, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
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
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromARGB(220, 105, 126, 80),
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding:
                              const EdgeInsets.fromLTRB(25, 0, 0, 0),
                          labelStyle: const TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 152, 152, 152),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromARGB(220, 105, 126, 80),
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, digite a data da aferição';
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
                  ],
                ),
              ),
              const SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(70, 0, 70, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Pressão sistólica:",
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
                        controller: _sistolicaController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromARGB(220, 105, 126, 80),
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding:
                              const EdgeInsets.fromLTRB(25, 0, 0, 0),
                          labelStyle: const TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 152, 152, 152),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromARGB(220, 105, 126, 80),
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, digite a pressão sistólica';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.fromLTRB(70, 0, 70, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Pressão diastólica:",
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
                        controller: _diastolicaController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromARGB(220, 105, 126, 80),
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          contentPadding:
                              const EdgeInsets.fromLTRB(25, 0, 0, 0),
                          labelStyle: const TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 152, 152, 152),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromARGB(220, 105, 126, 80),
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, digite a pressão diastólica';
                          }
                          return null;
                        },
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
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: const Color.fromARGB(50, 105, 126, 80),
                      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                      shape: const CircleBorder(),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Icon(Icons.close),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          pressaoAdicionar();
                          _selectedDate = null;
                          _sistolicaController.clear();
                          _diastolicaController.clear();
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Pressão cadastrada com sucesso!')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(50, 105, 126, 80),
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
              const SizedBox(height: 40),
              ..._pressaoData.map((item) => Text(item)).toList(),
            ],
          ),
        ),
      ),
    );
  }
}


// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/ui/firebase_sorted_list.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// //import 'package:firebase_database/firebase_database.dart';
// import 'package:intl/intl.dart';

// class NovaPressao extends StatefulWidget {
//   const NovaPressao({super.key});

//   @override
//   State<NovaPressao> createState() => _NovaPressaoState();
// }

// class _NovaPressaoState extends State<NovaPressao> {
//   //final databaseReference = FirebaseDatabase.instance.ref().child('pressoes');
//   String userId;
//   _NovaPressaoState() : userId = FirebaseAuth.instance.currentUser!.uid;
//   FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<void> definePressao(_diastolicaController, _sistolicaController) async {
//     await _firestore.collection(userId).doc(_diastolicaController.id).set(_diastolicaController.toMap());
//     await _firestore.collection(userId).doc(_sistolicaController.id).set(_sistolicaController.toMap());
//     await _firestore.collection(userId).doc(_dataController.id).set(_diastolicaController.toMap());
//   }

//   final _formKey = GlobalKey<FormState>();
//   final _dataController = TextEditingController();
//   final _sistolicaController = TextEditingController();
//   final _diastolicaController = TextEditingController();
//   final List<String> _pressaoData = [];
//   late DateTime? _selectedDate;
//   final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

//   @override
//   void initState() {
//     super.initState();
//     _selectedDate = null; // Inicializando _selectedDate com a data atual
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final ThemeData theme = Theme.of(context);
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate,
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//       builder: (BuildContext context, Widget? child) {
//         return Theme(
//           data: theme.copyWith(
//             // Personalize a cor de fundo da seleção aqui
//             colorScheme: theme.colorScheme.copyWith(
//               primary: const Color.fromARGB(
//                   220, 105, 126, 80), // Cor de fundo da seleção
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//     if (picked != null && picked != _selectedDate) {
//       setState(() {
//         _selectedDate = picked;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _dataController.dispose();
//     _sistolicaController.dispose();
//     _diastolicaController.dispose();
//     super.dispose();
//   }

//   //Future<void> _definePressao() async {
//     // await databaseReference.push().set({
//     //   'diastólica': _diastolicaController.text,
//     //   'sistólica': _sistolicaController.text,
//     //   'data': _dataController.text,
//     // });
//   //}

//   @override
//   Widget build(BuildContext context) {
//     // Navigator.pushReplacementNamed(
//     //   context,
//     //   '/pressao',
//     //   arguments: {
//     //     "data": _dataController.value.text,
//     //     "sistólica": _sistolicaController.value.text,
//     //     //"diastólica"; _diastolicaController.value.text,
//     //   }
//     // );

//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 245, 246, 241),
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 245, 246, 241),
//         iconTheme: const IconThemeData(
//           color: Color.fromARGB(220, 105, 126, 80), // Define a cor do ícone
//         ),
//         leading: Padding(
//           padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
//           child: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ),
//       ),
//       body: Center(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               const SizedBox(height: 20),
//               const Text(
//                 'Registre sua pressão',
//                 style: TextStyle(
//                   fontSize: 22,
//                   color: Color.fromARGB(220, 105, 126, 80),
//                   fontWeight: FontWeight.w900,
//                 ),
//               ),
//               const SizedBox(
//                 height: 100,
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(70, 0, 70, 0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Data da aferição:",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500,
//                         color: Color.fromARGB(220, 105, 126, 80),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     SizedBox(
//                       height: 40,
//                       child: TextFormField(
//                         readOnly: true,
//                         onTap: () => _selectDate(context),
//                         controller: TextEditingController(
//                           text: _selectedDate != null
//                               ? _dateFormat.format(_selectedDate!)
//                               : '',
//                         ),
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                   color: Color.fromARGB(220, 105, 126,
//                                       80)), // Altere a cor da borda aqui

//                               borderRadius: BorderRadius.circular(20)),
//                           contentPadding:
//                               const EdgeInsets.fromLTRB(25, 0, 0, 0),
//                           labelStyle: const TextStyle(
//                               fontSize: 18,
//                               color: Color.fromARGB(255, 152, 152, 152)),
//                           //quando clica na label
//                           focusedBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                   color: Color.fromARGB(220, 105, 126,
//                                       80)), // Altere a cor da borda aqui
//                               borderRadius: BorderRadius.circular(20)),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Por favor, digite a data da aferição';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 15.0,
//               ),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(70, 0, 70, 0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Pressão sistólica:",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500,
//                         color: Color.fromARGB(220, 105, 126, 80),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     SizedBox(
//                       height: 40,
//                       child: TextFormField(
//                         controller: _sistolicaController,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                   color: Color.fromARGB(220, 105, 126, 80)),
//                               borderRadius: BorderRadius.circular(20)),

//                           contentPadding:
//                               const EdgeInsets.fromLTRB(25, 0, 0, 0),
//                           labelStyle: const TextStyle(
//                               fontSize: 18,
//                               color: Color.fromARGB(255, 152, 152, 152)),
//                           //quando clica na label
//                           focusedBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                   color: Color.fromARGB(220, 105, 126,
//                                       80)), // Altere a cor da borda aqui
//                               borderRadius: BorderRadius.circular(20)),
//                         ),
//                         keyboardType: TextInputType.number,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Por favor, digite a pressão sistólica';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 15.0),
//               Padding(
//                 padding: const EdgeInsets.fromLTRB(70, 0, 70, 0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Pressão diastólica:",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500,
//                         color: Color.fromARGB(220, 105, 126, 80),
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     SizedBox(
//                       height: 40,
//                       child: TextFormField(
//                         controller: _diastolicaController,
//                         decoration: InputDecoration(
//                           border: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                   color: Color.fromARGB(220, 105, 126, 80)),
//                               borderRadius: BorderRadius.circular(20)),

//                           contentPadding:
//                               const EdgeInsets.fromLTRB(25, 0, 0, 0),
//                           labelStyle: const TextStyle(
//                               fontSize: 18,
//                               color: Color.fromARGB(255, 152, 152, 152)),
//                           //quando clica na label
//                           focusedBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(
//                                   color: Color.fromARGB(220, 105, 126,
//                                       80)), // Altere a cor da borda aqui
//                               borderRadius: BorderRadius.circular(20)),
//                         ),
//                         keyboardType: TextInputType.number,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Por favor, digite a pressão diastólica';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 30.0),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       padding: EdgeInsets
//                           .zero, // Define o padding do botão como zero para não interferir com o padding do widget interno
//                       backgroundColor: const Color.fromARGB(50, 105, 126, 80),
//                       foregroundColor: const Color.fromARGB(
//                           255, 255, 255, 255), // Cor de fundo do botão
//                       shape: const CircleBorder(),
//                     ),
//                     child: const Padding(
//                       padding:
//                           EdgeInsets.all(8), // Espaçamento interno para o ícone
//                       child: Icon(Icons.close),
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       if (_formKey.currentState!.validate()) {
//                         setState(() {
//                           //_pressaoData.add('Data: ${_dataController.text}, Sistólica: ${_sistolicaController.text}, Diastólica: ${_diastolicaController.text}');
//                           _definePressao();
//                           _dataController.clear();
//                           _sistolicaController.clear();
//                           _diastolicaController.clear();
//                         });
//                       }
//                       //Navigator.of(context).pop();
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color.fromARGB(
//                           50, 105, 126, 80), // Cor de fundo do botão
//                       foregroundColor: Colors.white,
//                       shape: const CircleBorder(),
//                     ),
//                     child: const Padding(
//                       padding: EdgeInsets.all(8),
//                       child: Icon(Icons.check),
//                     ),
//                   ),
//                 ],
//               ),
//               //child: ElevatedButton(
//               //onPressed: () {

//               //},
//               //style:backgroundColor: const Color.fromARGB(
//               //      50, 105, 126, 80),
//               //child: const Icon(Icons.add),
//               //),
//               const SizedBox(height: 40),
//               ..._pressaoData.map((item) => Text(item)).toList(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
