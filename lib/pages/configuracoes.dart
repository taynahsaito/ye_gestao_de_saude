import 'package:app_ye_gestao_de_saude/components/snackbar.dart';
import 'package:app_ye_gestao_de_saude/pages/sobre_nos.dart';
import 'package:app_ye_gestao_de_saude/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Configuracoes extends StatefulWidget {
  const Configuracoes({super.key});

  @override
  State<Configuracoes> createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  late DateTime? _selectedDate;
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  bool _senhaVisivel = false;

  String nome = '';
  String email = '';
  String senha = '';
  @override
  void initState() {
    super.initState();
    // _fetchUserData();
  }

  User? user = FirebaseAuth.instance.currentUser;

  // Future<void> _fetchUserData() async {
  //   try {
  //     User? user = FirebaseAuth.instance.currentUser;
  //     if (user != null) {
  //       DatabaseReference userRef =
  //           FirebaseDatabase.instance.ref().child('usuarios').child(user.uid);
  //       DatabaseEvent event = await userRef.once();
  //       DataSnapshot snapshot = event.snapshot;

  //       if (snapshot.exists) {
  //         setState(() {
  //           nome = snapshot.child('nome').value?.toString() ?? 'N/A';
  //           email = snapshot.child('email').value?.toString() ?? 'N/A';
  //           dataNasc = snapshot.child('dataNasc').value?.toString() ?? 'N/A';
  //           senha = snapshot.child('senha').value?.toString() ?? 'N/A';
  //         });
  //       } else {
  //         print('No data available for the user.');
  //       }
  //     } else {
  //       print('No user is currently signed in.');
  //     }
  //   } catch (e) {
  //     print('An error occurred while fetching user data: $e');
  //   }
  // }

  void _updateName() {
    String name = _nomeController.text.trim();
    if (name.isEmpty) return;
    String newName = name[0].toUpperCase() + name.substring(1);

    if (user != null) {
      DatabaseReference userRef =
          FirebaseDatabase.instance.ref().child('usuarios').child(user!.uid);
      userRef.update({'nome': newName}).then((_) async {
        setState(() {
          nome = newName; // Atualiza o nome na interface do usuário
        });
        showDialog(
          context: context,
          builder: (context) {
            return showSnackBar(
              context: context,
              texto: 'Nome atualizado!',
            );
          },
        );

        await Future.delayed(const Duration(seconds: 1));

        Navigator.pop(context);

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const SettingsPage(),
        //   ),
        // );
      }).catchError((error) {
        print('Erro ao atualizar o nome no Realtime Database: $error');
      });
    }
  }

  void resetPassword() {
    String email = _emailController.text.trim();
    FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .then((value) async {
      showDialog(
        context: context,
        builder: (context) {
          return showSnackBar(
            context: context,
            texto: 'Email para redefinição de senha enviado!',
          );
        },
      );
      await Future.delayed(const Duration(seconds: 1));

      Navigator.pop(context);

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const SettingsPage(),
      //   ),
      // );
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DatabaseReference userRef = FirebaseDatabase.instance
            .reference()
            .child('usuarios')
            .child(user.uid);
        userRef.update({'senha': 'nova_senha'}).then((_) {
          print('Senha atualizada no Realtime Database.');
        }).catchError((error) {
          print('Erro ao atualizar a senha no Realtime Database: $error');
        });
      }
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Erro'),
            content: const Text(
                'Não foi possível enviar o email de redefinição de senha. Por favor, verifique o endereço de email e tente novamente.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }

  AuthService authService = AuthService();

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
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            children: [
              Center(
                child: Image.asset(
                  'lib/assets/perfil.png',
                  width: 70,
                  height: 70,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Edite suas informações:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Color.fromARGB(220, 105, 126, 80),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 700,
                child: TextFormField(
                  controller: _nomeController,
                  decoration: const InputDecoration(
                    fillColor: Color.fromARGB(190, 223, 223, 223),
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    labelText: "Nome",
                    contentPadding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                    labelStyle: TextStyle(
                        fontSize: 18, color: Color.fromARGB(255, 105, 126, 80)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 700,
                child: TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    fillColor: Color.fromARGB(190, 223, 223, 223),
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    labelText: "E-mail",
                    contentPadding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                    labelStyle: TextStyle(
                        fontSize: 18, color: Color.fromARGB(255, 105, 126, 80)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 700,
                child: TextFormField(
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  controller: TextEditingController(
                    text: _selectedDate != null
                        ? _dateFormat.format(_selectedDate!)
                        : '',
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Data de nascimento',
                    hintStyle: TextStyle(
                        fontSize: 18, color: Color.fromARGB(255, 105, 126, 80)),
                    fillColor: Color.fromARGB(190, 223, 223, 223),
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                    labelStyle: TextStyle(
                        fontSize: 18, color: Color.fromARGB(255, 105, 126, 80)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 700,
                child: TextFormField(
                  controller: _senhaController,
                  decoration: InputDecoration(
                    fillColor: const Color.fromARGB(190, 223, 223, 223),
                    filled: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    labelText: "Senha",
                    contentPadding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                    labelStyle: const TextStyle(
                        fontSize: 18, color: Color.fromARGB(255, 105, 126, 80)),
                    suffixIcon: IconButton(
                      icon: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                        child: Icon(
                          _senhaVisivel
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: const Color.fromARGB(255, 105, 126, 80),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _senhaVisivel = !_senhaVisivel;
                        });
                      },
                    ),
                  ),
                  obscureText: !_senhaVisivel,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              FractionallySizedBox(
                widthFactor: 0.4,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: const Color.fromARGB(125, 133, 152, 100),
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Text(
                        "Salvar",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    backgroundColor: const Color.fromARGB(
                        200, 208, 76, 76), // Cor de fundo do botão
                  ),
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Text(
                      "Sair da conta",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: SizedBox(
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SobreNos()),
                      )
                    },
                    child: const Text(
                      "Sobre nós",
                      style: TextStyle(
                        fontSize: 18,
                        decoration: TextDecoration.underline,
                        color: Color.fromARGB(190, 133, 150, 112),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        )));
  }
}
