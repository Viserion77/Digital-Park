import 'package:DigitalPark/components/bottomMenuBar.dart';
import 'package:DigitalPark/models/service.dart';
import 'package:flutter/material.dart';

class ServicesList extends StatelessWidget {
  final List<Service> services = List();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 64.0, left: 32.0),
        child: Text(
          'Serviços',
          style: TextStyle(
            fontSize: 24.0,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      //ListView.builder(
      //  itemBuilder: (context, index) {
      //    final Service event = services[index];
      //    return _ServiceItem(event);
      //  },
      //  itemCount: services.length,
      //),
      bottomNavigationBar: BottomMenuBar(),
    );
  }
}

class _ServiceItem extends StatelessWidget {
  final Service service;

  _ServiceItem(this.service);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          service.name,
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        subtitle: Text(
          service.numero.toString(),
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
