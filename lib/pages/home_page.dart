import 'package:app_ye_gestao_de_saude/pages/glicemia.dart';
import 'package:app_ye_gestao_de_saude/pages/imc.dart';
import 'package:app_ye_gestao_de_saude/pages/peso_altura.dart';
import 'package:app_ye_gestao_de_saude/pages/pressao.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String userName = user != null ? user.displayName ?? '' : '';

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 246, 241),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 245, 246, 241),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
                0, 16, 16, 0), // Defina o padding aqui
            child: IconButton(
              icon: const Icon(
                Icons.settings,
                color: Color.fromARGB(220, 105, 126, 80),
              ),
              onPressed: () {},
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(55, 10, 40, 20),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              'lib/assets/perfil.png',
                              width: 70,
                              height: 70,
                            )
                          ],
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          // Use Expanded aqui para que o texto se expanda para preencher o espaço disponível
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Ajuste conforme necessário
                            children: [
                              Text(
                                "$userName",
                                style: const TextStyle(
                                  color: Color.fromARGB(220, 105, 126, 80),
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines:
                                    3, // Defina o número máximo de linhas que deseja mostrar
                                overflow: TextOverflow
                                    .visible, // Define como lidar com overflow de texto
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 90),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Pressão",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(220, 105, 126, 80),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Pressao()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(
                          30, 15, 15, 15), // Adiciona espaço à direita
                      backgroundColor: const Color.fromARGB(255, 223, 223, 223),
                      foregroundColor: Color.fromARGB(255, 113, 113, 113),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              "150X100 - Alta",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Color.fromARGB(255, 113, 113, 113),
                          size: 20.0,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Glicemia",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(220, 105, 126, 80),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Glicemia()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(
                          30, 15, 15, 15), // Adiciona espaço à direita
                      backgroundColor: const Color.fromARGB(255, 223, 223, 223),
                      foregroundColor: Color.fromARGB(255, 113, 113, 113),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              "1000X400 - Normal",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Color.fromARGB(255, 113, 113, 113),
                          size: 20.0,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Peso e altura",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(220, 105, 126, 80),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PesoAltura()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(
                          30, 15, 15, 15), // Adiciona espaço à direita
                      backgroundColor: const Color.fromARGB(255, 223, 223, 223),
                      foregroundColor: Color.fromARGB(255, 113, 113, 113),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              "64kg - 1.64cm",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Color.fromARGB(255, 113, 113, 113),
                          size: 20.0,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    " IMC",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(220, 105, 126, 80),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const IMC(tipo: "IMC")),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(
                          30, 15, 15, 15), // Adiciona espaço à direita
                      backgroundColor: const Color.fromARGB(255, 223, 223, 223),
                      foregroundColor: Color.fromARGB(255, 113, 113, 113),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              "31.14 - Obesidade I",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Color.fromARGB(255, 113, 113, 113),
                          size: 20.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
