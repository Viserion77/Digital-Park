import 'package:DigitalPark/components/basics.dart';
import 'package:DigitalPark/database/dao/session_dao.dart';
import 'package:DigitalPark/models/session.dart';
import 'package:DigitalPark/screens/home.dart';
import 'package:DigitalPark/screens/sign/up.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  final TextEditingController _controllerLogin = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  bool _staySignIn = false;
  final String _backgroundImageAsset = 'images/background.png';
  final String _logoImageAsset = 'images/logo.png';
  final SessionDao sessionDao = SessionDao();

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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset(
                  _logoImageAsset,
                  width: 160.0,
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
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              Container(
                                decoration: new BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16.0),
                                    bottomLeft: Radius.circular(16.0),
                                  ),
                                ),
                                height: 3,
                                width: 176,
                              ),
                            ],
                          ),
                        ),
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
                                    color:
                                        Theme.of(context).secondaryHeaderColor),
                              ),
                              Container(
                                color: Theme.of(context).secondaryHeaderColor,
                                height: 3,
                                width: 144,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => Cadastro()));
                        },
                      )
                    ],
                  ),
                ),
                Input(
                  controller: _controllerLogin,
                  label: 'E-mail ou apelido',
                  padding: const EdgeInsets.only(
                    top: 32.0,
                  ),
                ),
                Input(
                  controller: _controllerPassword,
                  label: 'Senha',
                  padding: const EdgeInsets.only(
                    top: 16.0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                    Text(
                      'Esqueceu a senha?',
                      style: TextStyle(
                        color: Theme.of(context).secondaryHeaderColor,
                      ),
                    )
                  ],
                ),
                Button(
                  label: 'Entrar',
                  onPressed: () {
                    if (_controllerLogin.text != '' &&
                        _controllerPassword.text != '') {
                      sessionDao.save(Session(
                          0,
                          _controllerLogin.text +
                              '^' +
                              _controllerPassword.text,
                          _staySignIn));
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Home()),
                      );
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
