import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventForm extends StatelessWidget {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nameControllerImpput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Cadastro de eventos'),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                'images/logo.png',
                width: 40,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Fteste'),
              style: TextStyle(fontSize: 24),
              keyboardType: TextInputType.text,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Fteste'),
              style: TextStyle(fontSize: 24),
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              width: double.maxFinite,
              child: RaisedButton(
                child: Text('create'),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
