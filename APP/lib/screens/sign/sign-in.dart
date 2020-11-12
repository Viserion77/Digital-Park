import 'package:flutter/material.dart';
import 'package:DigitalPark/components/basics.dart';
import 'package:DigitalPark/models/session.dart';
import 'package:DigitalPark/screens/events/list.dart';
import 'package:DigitalPark/screens/sign/sign-up.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  final TextEditingController _login = TextEditingController();
  final TextEditingController _password = TextEditingController();
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
                      onTap: () {},
                    ),
                    TextFunction(
                      label: 'Cadastrar',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Cadastro()),
                        );
                      },
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
                TextFunction(
                  label: 'Esqueceu a senha?',
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => EventsList()),
                    );
                  },
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
                  label: 'Entrar',
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
