import 'package:flutter/material.dart';

class InfoConsultas extends StatefulWidget {
  const InfoConsultas({super.key});

  @override
  State<InfoConsultas> createState() => _InfoConsultasState();
}

class _InfoConsultasState extends State<InfoConsultas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 246, 241),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 245, 246, 241),
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: Color.fromARGB(220, 105, 126, 80),
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
