import 'package:app_ye_gestao_de_saude/models/glicemia_model.dart';
import 'package:app_ye_gestao_de_saude/models/imc_model.dart';
import 'package:app_ye_gestao_de_saude/models/modelo_pressao.dart';
import 'package:app_ye_gestao_de_saude/models/peso_altura_model.dart';
import 'package:app_ye_gestao_de_saude/pages/configuracoes.dart';
import 'package:app_ye_gestao_de_saude/pages/glicemia.dart';
import 'package:app_ye_gestao_de_saude/pages/imc.dart';
import 'package:app_ye_gestao_de_saude/pages/peso_altura.dart';
import 'package:app_ye_gestao_de_saude/pages/pressao.dart';
import 'package:app_ye_gestao_de_saude/services/glicemia_service.dart';
import 'package:app_ye_gestao_de_saude/services/imc_service.dart';
import 'package:app_ye_gestao_de_saude/services/peso_altura_service.dart';
import 'package:app_ye_gestao_de_saude/services/pressao_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ModeloGlicemia? ultimaGlicemia;
  ModeloPressao? ultimaPressao;
  ModeloPesoAltura? ultimoPesoeAltura;
  ModeloIMC? ultimoIMC;

  Future<void> _carregarUltimaGlicemia() async {
    final ultimaGlicemiaAux = await GlicemiaService().getLatestGlucose();
    setState(() {
      ultimaGlicemia = ultimaGlicemiaAux;
    });
  }

  Future<void> _carregarUltimaPressao() async {
    final ultimaPressaoAux = await PressaoService().getLatestPressure();
    setState(() {
      ultimaPressao = ultimaPressaoAux;
    });
  }

  Future<void> _carregarUltimoPesoeAltura() async {
    final ultimoPesoeAlturaAux =
        await PesoAlturaService().getLatestWeightandHeight();
    setState(() {
      ultimoPesoeAltura = ultimoPesoeAlturaAux;
    });
  }

  Future<void> _carregarUltimoIMC() async {
    final ultimoIMCAux = await IMCService().getLatestIMC();
    setState(() {
      ultimoIMC = ultimoIMCAux;
    });
  }

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _carregarUltimaGlicemia();
      _carregarUltimaPressao();
      _carregarUltimoPesoeAltura();
      _carregarUltimoIMC();
    } else {
      print("Nenhum usuário logado. Não é possível carregar dados.");
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String userName = user != null ? user.displayName ?? '' : '';
    final GlicemiaService _glicemiaService = GlicemiaService();

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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Configuracoes()),
                );
              },
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
                      foregroundColor: const Color.fromARGB(255, 113, 113, 113),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              ultimaPressao != null
                                  ? '${ultimaPressao!.sistolica}x${ultimaPressao!.diastolica} mmHg'
                                  : '-mmHg',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const Icon(
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
                        MaterialPageRoute(builder: (context) => Glicemia()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(30, 15, 15, 15),
                      backgroundColor: const Color.fromARGB(255, 223, 223, 223),
                      foregroundColor: const Color.fromARGB(255, 113, 113, 113),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              ultimaGlicemia != null
                                  ? '${ultimaGlicemia!.glicemia} mg/dL'
                                  : '-mg/dL',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const Icon(
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
                        MaterialPageRoute(
                            builder: (context) => const PesoAltura()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(
                          30, 15, 15, 15), // Adiciona espaço à direita
                      backgroundColor: const Color.fromARGB(255, 223, 223, 223),
                      foregroundColor: const Color.fromARGB(255, 113, 113, 113),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              ultimoPesoeAltura != null
                                  ? '${ultimoPesoeAltura!.peso} kg - ${ultimoPesoeAltura!.altura} m'
                                  : '-mmHg',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const Icon(
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
                        MaterialPageRoute(builder: (context) => const IMC()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(
                          30, 15, 15, 15), // Adiciona espaço à direita
                      backgroundColor: const Color.fromARGB(255, 223, 223, 223),
                      foregroundColor: const Color.fromARGB(255, 113, 113, 113),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              ultimoIMC != null
                                  ? '${ultimoIMC!.imc} kg/m^2'
                                  : 'kg/m^2',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const Icon(
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
