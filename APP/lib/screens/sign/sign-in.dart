import 'package:flutter/material.dart';
import 'package:learning/components/basics.dart';
import 'package:learning/models/session.dart';
import 'package:learning/screens/events/list.dart';
import 'package:learning/screens/sign/sign-up.dart';

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
          color: Theme.of(context).primaryColor,
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
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Material(
                        color: Theme.of(context).primaryColor,
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            child: Text(
                              'Entrar',
                              style: TextStyle(
                                fontSize: 32,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Material(
                        color: Theme.of(context).primaryColor,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => Cadastro()),
                            );
                          },
                          child: Container(
                            child: Text(
                              'Cadastrar',
                              style: TextStyle(
                                fontSize: 32,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Imput(
                  controller: _login,
                  label: 'Apelido',
                ),
                Imput(
                  controller: _password,
                  label: 'Senha',
                ),
                Material(
                  color: Theme.of(context).primaryColor,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => EventsList()),
                      );
                    },
                    child: Container(
                      child: Text(
                        'Esqueceu a senha?',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Theme.of(context).primaryColor,
                  child: InkWell(
                    onTap: () {
                      setState(
                        () {
                          _staySignin = !_staySignin;
                        },
                      );
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(_staySignin
                              ? Icons.check_box_outline_blank
                              : Icons.check_box),
                          Text(
                            'Permanecer conectado?',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: RaisedButton(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'Entrar',
                        style: TextStyle(
                          fontSize: 32,
                        ),
                      ),
                    ),
                    onPressed: () {
                      final String login = _login.text;
                      final String password = _password.text;
                      final Session newSession = Session(0, login, password);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: RaisedButton(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'Pular',
                        style: TextStyle(
                          fontSize: 32,
                        ),
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
