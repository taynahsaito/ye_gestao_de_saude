import 'package:flutter/material.dart';

class NovaPressao extends StatefulWidget {
  const NovaPressao({super.key});

  @override
  State<NovaPressao> createState() => _NovaPressaoState();
}

class _NovaPressaoState extends State<NovaPressao> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 246, 241),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Text(
              'Registre sua pressão',
              style: TextStyle(
                fontSize: 22,
                color: Color.fromARGB(220, 105, 126, 80),
                fontWeight: FontWeight.w900,
              ),
            )
          ],
        ),
      ),
    );
  }
}
