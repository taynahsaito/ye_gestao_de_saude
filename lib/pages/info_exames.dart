import "package:flutter/material.dart";

class InfoExames extends StatefulWidget {
  final String tipo;

  const InfoExames({super.key, required this.tipo});

  @override
  State<InfoExames> createState() => _InfoExamesState();
}

class _InfoExamesState extends State<InfoExames> {
  final TextEditingController _exameController = TextEditingController();
  var exameTipo = '98';

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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30.0),
                  child: Text(
                    "${widget.tipo}",
                    style: const TextStyle(
                      fontSize: 22,
                      color: Color.fromARGB(220, 105, 126, 80),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: SizedBox(
                    height: 80,
                    width: 450,
                    child: GestureDetector(
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                              title: const Text("Editar exame:"),
                              content: SizedBox(
                                height: 30,
                                child: TextFormField(
                                  controller: _exameController,
                                  decoration: InputDecoration(
                                    fillColor:
                                        Color.fromARGB(190, 223, 223, 223),
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
                                    ),
                                    labelText:
                                        "Valor do exame de ${widget.tipo}",
                                    contentPadding:
                                        EdgeInsets.fromLTRB(25, 0, 0, 0),
                                    labelStyle: TextStyle(
                                        fontSize: 18,
                                        color:
                                            Color.fromARGB(255, 152, 152, 152)),
                                  ),
                                ),
                              )),
                        );
                        exameTipo = _exameController.text;
                      },
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(219, 127, 88, 0.53),
                          borderRadius: BorderRadius.all(Radius.circular(17)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "10/05/2024",
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              '$exameTipo mg/dl',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: Color.fromRGBO(150, 54, 30, 0.829),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 450,
                  child: Text(
                    'Esse resultado está fora dos limites de referência. Consulte seu médico para mais informações.',
                    style: TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(150, 54, 30, 0.829)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: SizedBox(
                    height: 80,
                    width: 450,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                              title: const Text("Editar exame:"),
                              content: SizedBox(
                                height: 30,
                                child: TextFormField(
                                  controller: _exameController,
                                  decoration: InputDecoration(
                                    fillColor:
                                        Color.fromARGB(190, 223, 223, 223),
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
                                    ),
                                    labelText:
                                        "Valor do exame de ${widget.tipo}",
                                    contentPadding:
                                        EdgeInsets.fromLTRB(25, 0, 0, 0),
                                    labelStyle: TextStyle(
                                        fontSize: 18,
                                        color:
                                            Color.fromARGB(255, 152, 152, 152)),
                                  ),
                                ),
                              )),
                        );
                      },
                      child: const DecoratedBox(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(167, 216, 119, 0.5),
                          borderRadius: BorderRadius.all(Radius.circular(17)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "14/05/2024",
                              style: TextStyle(fontSize: 12),
                            ),
                            Text(
                              '105 mg/dl',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                                color: Color.fromRGBO(62, 100, 23, 1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
