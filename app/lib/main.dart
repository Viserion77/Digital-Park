import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Core(),
    );
  }
}

class Core extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          GetImage(
            ObjImagem(
              'https://static.ndonline.com.br/2018/03/f9955999704006bcb9ffca74fb08d5a55b543bdd.png',
              150,
            ),
          ),
          Row(
            children: <Widget>[
              Text('Entrar'),
              Text('Cadastrar'),
            ],
          ),
          Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text('Apelido'),
                  Text('Imput'),
                ],
              ),
              Column(
                children: <Widget>[
                  Text('Senha'),
                  Text('Imput'),
                ],
              ),
              Text('Esqueceu a senha?'),
              Row(
                children: <Widget>[
                  Text('button'),
                  Text('Permanecer conectado'),
                ],
              ),
            ],
          ),
        ],
      ),
      color: Colors.lime,
    );
  }
}

class GetImage extends StatelessWidget {
  final ObjImagem _objImagem;

  GetImage(this._objImagem);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(
        _objImagem.imagemUrl.toString(),
        width: _objImagem.sizeWidth.toDouble(),
      ),
    );
  }
}

class ObjImagem {
  final String imagemUrl;
  final double sizeWidth;

  ObjImagem(this.imagemUrl, this.sizeWidth);
}

//return MaterialApp(
//      home: Scaffold(
//        body: Text('Homa page'),
//        appBar: AppBar(
//          title: Text('Parque Malwee'),
//        ),
//      ),
//    );
//}
