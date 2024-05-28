import 'package:app_ye_gestao_de_saude/pages/sobre_nos.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Configuracoes extends StatefulWidget {
  const Configuracoes({super.key});

  @override
  State<Configuracoes> createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {

  bool _senhaVisivel = false;
  late DateTime? _selectedDate;
  final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');
  bool isChecked = false;
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

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
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Center(
                child: Image.asset('lib/assets/perfil.png',
                                  width: 70,
                                  height: 70,),
              ),
              const SizedBox(height: 50),
              const Text("Edite suas informações:", style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Color.fromARGB(220, 105, 126, 80),
                    ),),
              const SizedBox(height: 30),
              SizedBox(width: 700,
                    child:
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
                                color: Color.fromARGB(255, 105, 126, 80)),
                          ),
                        ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(width: 700,
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
                            fontSize: 18,
                            color: Color.fromARGB(255, 105, 126, 80)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(width: 700,
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
                        hintStyle: TextStyle(fontSize: 18, color:  Color.fromARGB(255, 105, 126, 80)),
                        fillColor: Color.fromARGB(190, 223, 223, 223),
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(25, 0, 0, 0),
                        labelStyle: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 105, 126, 80)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(width: 700,
                    child: TextFormField(
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
                            color: Color.fromARGB(255, 105, 126, 80)),
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
          
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: (){}, 
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Color.fromARGB(255, 105, 126, 80),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(35, 5, 25, 5),
                        child: Text(
                          "Salvar", 
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700
                          ),),
                      ),
                      ),
                  ),
          
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: (){}, 
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15),
                        backgroundColor:
                            const Color.fromARGB(200, 208, 76, 76), // Cor de fundo do botão
                      ),
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Text(
                          "Sair da conta", 
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700
                          ),),
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:28.0),
                    child: SizedBox(
                      child: GestureDetector(
                        onTap: () => {
                          Navigator.push(
                            context, 
                            MaterialPageRoute(
                             builder: (context) =>
                                  const SobreNos()),)
                         },
                        child: const Text(
                          "Sobre nós", 
                        style: TextStyle(
                          fontSize: 18,
                          decoration:  TextDecoration.underline,
                          color: Color.fromARGB(255, 105, 126, 80),
                          fontWeight: FontWeight.w900,
                    
                        ),
                        ),
                    
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
            ],
            ),
        )
                 
    )
    );
  }
}