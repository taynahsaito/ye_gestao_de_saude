import 'package:app_ye_gestao_de_saude/pages/info_exames.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'comprovante_page.dart'; // Adicione a importação da ComprovantePage

class Exames extends StatefulWidget {
  const Exames({super.key});

  @override
  State<Exames> createState() => _ExamesState();
}

class _ExamesState extends State<Exames> {
  // banco de dados
  final databaseReference = FirebaseDatabase.instance.ref().child('usuarios');

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text('Usuário não autenticado.'),
        ),
      );
    }

    var email = user.email;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 246, 241),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 30.0),
                      child: Text(
                        "Histórico de Exames",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(220, 105, 126, 80),
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    _buildExamTile(context, 'Hemograma', 'Hemoglobina'),
                    _buildExamTile(
                        context, 'Colesterol Total', 'Colesterol Total'),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return _buildBottomSheet();
                    },
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

  Widget _buildExamTile(BuildContext context, String title, String tipo) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InfoExames(tipo: tipo),
            ),
          );
        },
        child: SizedBox(
          height: 40,
          width: 450,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.info_outline),
                onPressed: () {
                  _showInfoSnackbar(context, title);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showInfoSnackbar(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(
            color: const Color.fromRGBO(190, 186, 186, 0.815),
            width: 2,
          ),
        ),
        child: const SizedBox(
          height: 100,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                "O hemograma pode ajudar a detectar doenças como anemia, alguns tipos de câncer como leucemia, infecções e inflamações, problemas no sistema imunológico, entre outras.",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }

  Widget _buildBottomSheet() {
    return SizedBox(
      height: 150,
      width: 400,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(129, 152, 100, 53.33),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: ElevatedButton(
                child: const Text('Fazer upload de arquivo'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ComprovantePage(), // Redireciona para a ComprovantePage
                    ),
                  );
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                child: const Text('Tirar foto'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ComprovantePage(), // Redireciona para a ComprovantePage
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
