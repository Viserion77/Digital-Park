import 'package:flutter/material.dart';
import 'package:DigitalPark/components/basics.dart';
import 'package:DigitalPark/screens/sign/in.dart';

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
  final String _backgroundImageAsset = 'images/background.png';
  final String _logoImageAsset = 'images/logo.png';

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
                          Navigator.of(context).push(
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
                  value: _staySignin,
                  function: () {
                    setState(
                      () {
                        _staySignin = !_staySignin;
                      },
                    );
                  },
                ),
                Button(
                  label: 'Cadastrar',
                  onPressed: () {},
                ),
                Button(
                  label: 'Com o Google',
                  onPressed: () {},
                  imageAsset: 'images/icons/google.png',
                  backgroundColor: Colors.white,
                  fontColor: Colors.blueAccent,
                ),
                Button(
                  label: 'Com o Facebook',
                  onPressed: () {},
                  imageAsset: 'images/icons/facebook.png',
                  backgroundColor: Colors.white,
                  fontColor: Colors.indigo,
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
