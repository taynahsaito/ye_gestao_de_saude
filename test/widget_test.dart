// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// import 'package:app_ye_gestao_de_saude/main.dart';

// void main() {
//   testWidgets('Botão de entrar na página de login',
//       (WidgetTester tester) async {
//     // Build our app and trigger a frame.
//     await tester.pumpWidget(const MyApp());

//     // Verify that we're on the login page initially.
//     expect(find.text('Cadastre-se'), findsOneWidget);
//     expect(find.text('Home'), findsNothing);

//     // Tap the login button.
//     await tester.tap(find.text('Entrar'));
//     await tester.pumpAndSettle();

//     print('Widget tree after tapping login button:');
//     debugDumpApp();

//     // Verify that we've navigated to the home page.
//     // expect(find.text('Entrar'), findsNothing);
//     expect(find.text('Pressão'), findsOneWidget);
//   });
// }
import 'package:app_ye_gestao_de_saude/main.dart';
import 'package:app_ye_gestao_de_saude/pages/home_page.dart';
import 'package:app_ye_gestao_de_saude/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      'Teste de navegação para tela inicial após pressionar botão de entrar',
      (WidgetTester tester) async {
    // Construa o widget principal do aplicativo
    await tester.pumpWidget(const MaterialApp(home: Login()));

    expect(find.text('Entrar'), findsOneWidget);
    expect(find.byIcon(Icons.visibility), findsOneWidget);
    // Encontre e toque no botão de entrar
    await tester.tap(find.text('Entrar'));
    await tester.pumpAndSettle();

    // Verifique se a navegação para a tela inicial ocorreu
    expect(find.byType(HomePage), findsOneWidget);
  });
}
