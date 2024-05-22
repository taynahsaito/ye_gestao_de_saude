import "dart:io";
import "package:app_ye_gestao_de_saude/pages/camera.dart";
import "package:app_ye_gestao_de_saude/pages/historico_exames.dart";
import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import 'package:image_cropper/image_cropper.dart';

class Exames extends StatefulWidget {
  const Exames({super.key});

  @override
  State<Exames> createState() => _ExamesState();
}

class _ExamesState extends State<Exames> {



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 246, 241),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                child: Text(
                  "Exames",
                  style: TextStyle(
                    fontSize: 22,
                    color: Color.fromARGB(220, 105, 126, 80),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const HistoricoExames(tipo: 'Hemoglobina')),
                    );
                  },
                  child: SizedBox(
                    height: 40,
                    width: 450,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Hemograma",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w900),
                        ),
                        IconButton(
                          icon: const Icon(Icons.info_outline),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: DecoratedBox(
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  border: Border.all(
                                    color: const Color.fromRGBO(
                                        190, 186, 186, 0.815),
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
                                    )),
                              ),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            ));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const HistoricoExames(tipo: "Colesterol Total")),
                    );
                  },
                  child: SizedBox(
                    height: 40,
                    width: 450,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Colesterol Total",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w900),
                        ),
                        IconButton(
                          icon: const Icon(Icons.info_outline),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: DecoratedBox(
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  border: Border.all(
                                    color: const Color.fromRGBO(
                                        190, 186, 186, 0.815),
                                    width: 2,
                                  ),
                                ),
                                child: const SizedBox(
                                    height: 100,
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Center(
                                        child: Text(
                                          "Colesterol total é um exame para mostrar os níveis de colesterol no organismo do paciente a partir de uma amostra de sangue.",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    )),
                              ),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            ));
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                  height: 150,
                  width: 400,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(129, 152, 100, 53.33)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: ElevatedButton(
                            child: const Text('Fazer upload de arquivo'),
                            onPressed: () {
                              //  getImageFromGallery();
                            },
                          ),
                        ),
                        Center(
                          child: ElevatedButton(
                            child: const Text('Tirar foto'),
                            onPressed: () {
                               Navigator.of(context).pop();
                              // getImageFromCamera();
                              Navigator.push(
                                context, 
                                MaterialPageRoute(builder: (context) => const CameraScreen())
                                );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(15),
            backgroundColor:
                const Color.fromARGB(50, 105, 126, 80), // Cor de fundo do botão
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(600),
            ),
          ),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
