import 'package:app_ye_gestao_de_saude/components/snackbar.dart';
import 'package:app_ye_gestao_de_saude/pages/home_page.dart';
import 'package:app_ye_gestao_de_saude/services/auth_service.dart';
import 'package:app_ye_gestao_de_saude/widgets/nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:app_ye_gestao_de_saude/pages/cadastro.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _senhaVisivel = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  final databaseReference =
      FirebaseDatabase.instance.reference().child('usuarios');
  final AuthService _autenServico = AuthService();

  signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: gAuth.idToken,
        accessToken: gAuth.accessToken,
      );

      final authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (authResult.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NavBar()),
        );
      }
    } catch (error) {
      print('Erro ao fazer login com o Google: $error');
    }
  }

  Future<void> signInWithFacebook(BuildContext context) async {
    final LoginResult loginResult = await FacebookAuth.instance
        .login(permissions: ['email', 'public_profile']);

    final userData = await FacebookAuth.instance.getUserData();

    final userEmail = userData['email'];

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    try {
      final authResult = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);

      if (authResult.user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NavBar()),
        );
      }
    } catch (e) {
      print("Erro ao fazer login com o Facebook: $e");
      // Trate o erro adequadamente, como exibindo uma mensagem de erro para o usuário.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 246, 241),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 0, 40, 20),
        child: Center(
          child: Form(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/assets/Logo_gestao_em_saude.png',
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
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
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
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
                        )),
                    obscureText: !_senhaVisivel,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  FractionallySizedBox(
                    widthFactor:
                        0.5, // Define a largura do botão como metade da largura da tela (valor entre 0.0 e 1.0)
                    child: ElevatedButton(
                      onPressed: () async {
                        String email = _emailController.text;
                        String senha = _senhaController.text;

                        // Aguarde o resultado do método de login
                        String? errorMessage = await _autenServico.login(
                            email: email, senha: senha);

                        // Verifique se o login foi bem-sucedido (sem mensagem de erro)
                        if (errorMessage == null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NavBar(),
                            ),
                          );
                        } else {
                          // Exiba a mensagem de erro ao usuário
                          showSnackBar(
                            context: context,
                            texto: errorMessage,
                            isErro: true,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                        backgroundColor:
                            const Color.fromARGB(80, 133, 152, 100),
                        foregroundColor:
                            const Color.fromARGB(255, 255, 255, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "Entrar",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: Text(
                      "Ou entre com",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(220, 133, 152, 100)),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                              onTap: () {
                                signInWithFacebook(context);
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
                                signInWithGoogle(context);
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
                  Container(
                    constraints: const BoxConstraints(
                        maxWidth: 600), // Defina a largura máxima desejada
                    child: Center(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          const Text(
                            "Não tem uma conta? ",
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
                                      builder: (context) => const Cadastro()),
                                );
                              },
                              child: const Text(
                                "Cadastre-se",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    color: Color.fromARGB(220, 133, 152, 100)),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context, 
                                MaterialPageRoute(builder: (context) => const NavBar())
                                );
                            },
                            child: Text("homepage")
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NavBar(),
                          ),
                        );
                      },
                      child: const Text("homepage")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
