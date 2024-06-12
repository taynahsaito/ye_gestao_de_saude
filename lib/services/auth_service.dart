import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String?> cadastrarUsuario({
    required String nome,
    required String email,
    required String senha,
  }) async {
    try {
      // Verifica se a senha atende aos critérios
      if (senha.length < 8) {
        return "A senha deve ter no mínimo 8 caracteres";
      } else if (!senha.contains(RegExp(r'[0-9]'))) {
        return "A senha deve conter pelo menos um número. (Exemplo: 1, 2, 3)";
      } else if (!senha.contains(RegExp(r'[A-Z]'))) {
        return "A senha deve conter pelo menos uma letra maiúscula. (Exemplo: A, B, C)";
      } else if (!senha.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        return "A senha deve conter pelo menos um caractere especial.  (Exemplo: @, #, %)";
      }

      // Verifica se nome e sobrenome contêm apenas letras e espaços
      if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(nome)) {
        return "Por favor, insira um nome válido";
      }

      // Cria o usuário
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      await userCredential.user!.updateDisplayName(nome);
      await userCredential.user!.sendEmailVerification();
      return null; // Cadastro bem-sucedido
    } on FirebaseAuthException catch (e) {
      // Trata os erros específicos do Firebase Auth
      if (nome.isEmpty || email.isEmpty || senha.isEmpty) {
        return "Há campos que não estão preenchidos";
      } else if (e.code == "email-already-in-use") {
        return "O usuário já está cadastrado!";
      } else if (!email.contains('@')) {
        return "Insira um endereço de e-mail válido.";
      } else if (email.length < 5) {
        return "O e-mail é muito curto";
      }
      return e
          .message; // Retorna a mensagem de erro da exceção FirebaseAuthException
    } catch (e) {
      // Captura exceções não tratadas e exibe uma mensagem genérica
      print("Erro ao cadastrar usuário: $e");
      return "Erro ao cadastrar usuário. Tente novamente mais tarde.";
    }
  }

  Future<String?> login({required String email, required String senha}) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );

      if (!userCredential.user!.emailVerified) {
        // Se o e-mail não estiver verificado, retorne uma mensagem informando o usuário
        return 'Seu email não foi verificado. Verifique seu e-mail na caixa de entrada ou  na aba "Spam" e tente novamente.';
      }

      return null; // Login bem-sucedido
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return 'O usuário não foi encontrado. Verifique o e-mail digitado.';
        case 'wrong-password':
          return 'Senha incorreta. Tente novamente.';
        default:
          return e.message; // Retornar mensagem padrão para outros erros
      }
    } catch (e) {
      print("Erro ao fazer login: $e");
      return "Erro ao fazer login. Tente novamente mais tarde.";
    }
  }

  String? getCurrentUser() {
    User? user = _firebaseAuth.currentUser;
    return user?.uid;
  }

  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }
}
