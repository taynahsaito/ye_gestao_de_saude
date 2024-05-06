import 'package:app_ye_gestao_de_saude/components/snackbar.dart';
import 'package:app_ye_gestao_de_saude/services/auth_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:app_ye_gestao_de_saude/pages/home_page.dart';
import 'package:app_ye_gestao_de_saude/pages/login.dart';
import 'package:intl/intl.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  bool _senhaVisivel = false;
  late DateTime? _selectedDate;
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  bool isChecked = false;
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final databaseReference =
      FirebaseDatabase.instance.reference().child('usuarios');
  AuthService _autenServico = AuthService();

  Future<void> loginWithGoogle(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        // Sucesso ao fazer login com o Google
        // Você pode prosseguir com o que deseja fazer após o login bem-sucedido
        // Por exemplo, navegar para a próxima tela
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      } else {
        // Cancelado pelo usuário
        print('Login com Google cancelado.');
      }
    } catch (error) {
      // Tratar erros de autenticação do Google
      print('Erro ao fazer login com o Google: $error');
    }
  }

  Future<void> _loginWithFacebook(BuildContext context) async {
    try {
      final permissions = ['email', 'public_profile'];
      final LoginResult result =
          await FacebookAuth.instance.login(permissions: permissions);

      if (result.status == LoginStatus.success) {
        // Sucesso ao fazer login com o Facebook
        // Faça o que precisar aqui, como navegar para a próxima tela
      } else {
        // O usuário cancelou o login ou ocorreu um erro
        print('Login com Facebook cancelado ou falhou.');
      }
    } catch (error) {
      // Tratar erros de autenticação do Facebook
      print('Erro ao fazer login com o Facebook: $error');
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 246, 241),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 10, 40, 20),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Crie uma conta para começar',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(220, 105, 126, 80),
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
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
                        fontSize: 18,
                        color: Color.fromARGB(255, 152, 152, 152)),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
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
                        fontSize: 18,
                        color: Color.fromARGB(255, 152, 152, 152)),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _senhaController,
                  decoration: InputDecoration(
                    fillColor: Color.fromARGB(190, 223, 223, 223),
                    filled: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    labelText: "Senha",
                    contentPadding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
                    labelStyle: const TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 152, 152, 152)),
                    suffixIcon: IconButton(
                      icon: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                        child: Icon(
                          _senhaVisivel
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: const Color.fromARGB(255, 152, 152, 152),
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
                const SizedBox(height: 20),
                TextFormField(
                  readOnly: true,
                  onTap: () => _selectDate(context),
                  controller: TextEditingController(
                    text: _selectedDate != null
                        ? _dateFormat.format(_selectedDate!)
                        : '',
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Selecione a data de nascimento',
                    fillColor: Color.fromARGB(190, 223, 223, 223),
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    contentPadding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                    labelStyle: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 152, 152, 152)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      // controlAffinity: ListTileControlAffinity.leading,
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Concordo com os ",
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(220, 133, 152, 100)),
                        ),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Cadastro()),
                              );
                            },
                            child: const Text(
                              "Termos de uso e privacidade",
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w900,
                                  color: Color.fromARGB(220, 133, 152, 100)),
                            ),
                          ),
                        )
                      ],
                    ))
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                FractionallySizedBox(
                  widthFactor:
                      0.5, // Define a largura do botão como metade da largura da tela (valor entre 0.0 e 1.0)
                  child: ElevatedButton(
                    onPressed: () async {
                      // Verifica se os campos obrigatórios estão preenchidos
                      if (_nomeController.text.isEmpty ||
                          _emailController.text.isEmpty ||
                          _senhaController.text.isEmpty) {
                        showSnackBar(
                          context: context,
                          texto: "Há campos não preenchidos",
                        );
                        return;
                      }

                      // Chama o método cadastrarUsuario do AuthService
                      String? mensagemErro =
                          await AuthService().cadastrarUsuario(
                        nome: _nomeController.text,
                        email: _emailController.text,
                        senha: _senhaController.text,
                      );

                      if (mensagemErro == null) {
                        // Cadastro de usuário bem-sucedido, agora salve os dados no banco de dados
                        String dataNascimento = _selectedDate != null
                            ? _dateFormat.format(_selectedDate!)
                            : '';
                        try {
                          await databaseReference.push().set({
                            'nome': _nomeController.text,
                            'email': _emailController.text,
                            'senha': _senhaController.text,
                            'dataNascimento': dataNascimento,
                          });

                          showSnackBar(
                            context: context,
                            texto:
                                "Cadastro feito com sucesso! Verifique seu email!",
                            isErro: false,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                          );
                        } catch (error) {
                          // Ocorreu um erro ao enviar os dados para o Firebase
                          showSnackBar(
                            context: context,
                            texto: "Erro ao cadastrar usuário: $error",
                          );
                        }
                      } else {
                        // Exiba a mensagem de erro do cadastro do usuário
                        showSnackBar(context: context, texto: mensagemErro);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                      backgroundColor: const Color.fromARGB(220, 105, 126, 80),
                      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Cadastrar",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text(
                    "Ou",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(220, 105, 126, 80)),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                            onTap: () {
                              _loginWithFacebook(context);
                            },
                            child: Image.asset(
                              'lib/assets/face.png',
                              width: 40,
                              height: 40,
                            )),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                            onTap: () {
                              loginWithGoogle(context);
                            },
                            child: Image.asset(
                              'lib/assets/google.png',
                              width: 40,
                              height: 40,
                            )),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Já possui uma conta? ",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(220, 133, 152, 100)),
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                          );
                        },
                        child: const Text(
                          "Entrar",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: Color.fromARGB(220, 133, 152, 100)),
                        ),
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
