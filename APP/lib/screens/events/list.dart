import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learning/screens/events/form.dart';

class EventsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Image.asset(
              'images/logo.png',
              width: 40,
            ),
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              title: Text(
                '1',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              subtitle: Text(
                'data',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => EventForm()),
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
