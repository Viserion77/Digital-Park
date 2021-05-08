import 'package:DigitalPark/components/basics.dart';
import 'package:DigitalPark/database/dao/session_dao.dart';
import 'package:DigitalPark/http/web_client.dart';
import 'package:DigitalPark/models/session.dart';
import 'package:DigitalPark/screens/home.dart';
import 'package:DigitalPark/screens/sign/in.dart';
import 'package:flutter/material.dart';

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
  bool _staySignIn = false;
  final String _backgroundImageAsset = 'images/background.png';
  final String _logoImageAsset = 'images/logo.png';

  SessionDao sessionDao = SessionDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(_backgroundImageAsset),
            fit: BoxFit.cover,
          ),
        ),
        height: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 32.0,
            left: 32.0,
            right: 32.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Image.asset(
                  _logoImageAsset,
                  width: 160,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Entrar',
                                style: TextStyle(
                                  fontSize: 32.0,
                                  color: Theme.of(context).secondaryHeaderColor,
                                ),
                              ),
                              Container(
                                decoration: new BoxDecoration(
                                  color: Theme.of(context).secondaryHeaderColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16.0),
                                    bottomLeft: Radius.circular(16.0),
                                  ),
                                ),
                                height: 3,
                                width: 96.0,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Cadastrar',
                                style: TextStyle(
                                    fontSize: 32,
                                    color: Theme.of(context).primaryColor),
                              ),
                              Container(
                                color: Theme.of(context).primaryColor,
                                height: 3,
                                width: 224.0,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Input(
                  controller: _login,
                  label: 'Apelido',
                  padding: const EdgeInsets.only(
                    top: 32.0,
                  ),
                ),
                Input(
                  controller: _password,
                  label: 'Senha',
                  padding: const EdgeInsets.only(
                    top: 16.0,
                  ),
                ),
                Input(
                  controller: _passwordConfirmation,
                  label: 'Confirmar Senha',
                  padding: const EdgeInsets.only(
                    top: 16.0,
                  ),
                ),
                LabelBox(
                  label: 'Permanecer conectado?',
                  value: _staySignIn,
                  function: () {
                    setState(
                      () {
                        _staySignIn = !_staySignIn;
                      },
                    );
                  },
                ),
                Button(
                  label: 'Cadastrar',
                  onPressed: () async {
                    if (_login.text != '' &&
                        _password.text != '' &&
                        _password.text == _passwordConfirmation.text) {
                      postNewUser(_login.text, _password.text);
                      String oAuthResponse =
                          await getOAuthToken(_login.text, _password.text);
                      print(getOAuthToken);
                      sessionDao.save(Session(0, oAuthResponse, _staySignIn));
                      Session session = await sessionDao.getLast();
                      if (session.isAuthenticated()) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Home()),
                        );
                      }
                    }
                  },
                ),
                Button(
                  label: 'Com o Google',
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                  imageAsset: 'images/icons/google.png',
                  backgroundColor: Colors.white,
                  fontColor: Colors.blueAccent,
                ),
                Button(
                  label: 'Com o Facebook',
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                  imageAsset: 'images/icons/facebook.png',
                  backgroundColor: Colors.white,
                  fontColor: Colors.indigo,
                ),
                Button(
                  label: 'Pular',
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
