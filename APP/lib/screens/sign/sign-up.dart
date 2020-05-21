import 'package:flutter/material.dart';
import 'package:learning/components/basics.dart';
import 'package:learning/models/session.dart';
import 'package:learning/screens/sign/sign-in.dart';

class Cadastro extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CadastroState();
  }
}

class CadastroState extends State<Cadastro> {
  final TextEditingController _login = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordConfirmation = TextEditingController();
  bool _staySignin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Theme.of(context).backgroundColor,
          width: double.maxFinite,
          height: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: Image.asset(
                    'images/logo.png',
                    width: 150,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFunction(
                      label: 'Entrar',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                    ),
                    TextFunction(
                      label: 'Cadastrar',
                      onTap: () {},
                    ),
                  ],
                ),
                Input(
                  controller: _login,
                  label: 'Apelido',
                ),
                Input(
                  controller: _password,
                  label: 'Senha',
                ),
                Input(
                  controller: _passwordConfirmation,
                  label: 'Confirmar Senha',
                ),
                TextFunction(
                  label: 'Permanecer conectado?',
                  icon: _staySignin
                      ? Icons.check_box_outline_blank
                      : Icons.check_box,
                  onTap: () {
                    setState(
                      () {
                        _staySignin = !_staySignin;
                      },
                    );
                  },
                ),
                Button(
                  label: 'Cadastrar',
                  onPressed: () {
                    final String login = _login.text;
                    final String password = _password.text;
                    final Session newSession = Session(0, login, password);
                  },
                ),
                Button(
                  label: 'Pular',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
